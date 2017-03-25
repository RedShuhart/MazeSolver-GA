public enum Step {
        UP("00"),
        DOWN("01"),
        LEFT("10"),
        RIGHT("11");

        private String text;

        private Step(String text) {
            this.text = text;
        }

        public String getText() {
            return this.text;
        }

        public static Step fromString(String text) {
            for (Step b : Step.values()) {
                if (b.text.equalsIgnoreCase(text)) {
                    return b;
                }
            }
            return null;
        }
    }