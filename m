Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6194176C3B5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjHBDvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHBDvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:51:01 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2961BF;
        Tue,  1 Aug 2023 20:51:00 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so6425962f8f.2;
        Tue, 01 Aug 2023 20:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690948259; x=1691553059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+k3JK6aQF5cAqgDoWdyK8Jvm08ED04BKfngPZoEvJSE=;
        b=Jwrw2X5dot9pBJmQ96XrLi4dEUVZ0jSozHkT1j6vtRpdHfHrq5st8TB0n0Gqt1HN2N
         70Osl6aBrWkYwqFMFi7+ceY3U4sFSvtCH/i2ZdwGG+jCh7H7meW5d/Qek741y43jcBmo
         Bl/s0/bQZY5ju6yusfyC6izkw50ibbAKVZDWQTNQL8DIzn/e1XK91iXR25sTIZBxmzfk
         x1lEqJ/zJMSO22qOEQIYUHaFbDcfd4jPF8tmkSNDNPpeYHp4NRROqkAZ1oXf+QjfG82v
         lKG3iKRgBTNMk1ExEENu+/f718xHCaYA4jhEm6Os25EO4a36BuY8SYycmQnnI9hfoPA0
         76Jw==
X-Gm-Message-State: ABy/qLaf+9y/B/37R6DfYGBE4KTjkpBVGzDNWz210MsEIs77v9YpKAEx
        W7Db17QXnrArlgIHBu483tw=
X-Google-Smtp-Source: APBJJlGDUfus6TVLksFT3hhSFR5gvR0ULTL8x4zd7hiII1wVXyi3dIPlepaP7GyFCvgaCa9J5h9d+w==
X-Received: by 2002:adf:e8c1:0:b0:314:4db:e0bd with SMTP id k1-20020adfe8c1000000b0031404dbe0bdmr3959882wrn.11.1690948258469;
        Tue, 01 Aug 2023 20:50:58 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:199:8930:2c90:cb9e:b154:73dc])
        by smtp.gmail.com with ESMTPSA id z8-20020adfec88000000b0031773a8e5c4sm17622152wrn.37.2023.08.01.20.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 20:50:57 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH] docs: rtla: replace dashes with spaces in titles
Date:   Wed,  2 Aug 2023 06:50:36 +0300
Message-ID: <20230802035037.404230-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

because
- Titles containing spaces offer better readability compared
  to those with dashes
- Commands and their described subcommands are separated by spaces
- Ensure that the titles are identical to the commands with subcommands

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/tools/rtla/rtla-hwnoise.rst       | 2 +-
 Documentation/tools/rtla/rtla-osnoise-hist.rst  | 2 +-
 Documentation/tools/rtla/rtla-osnoise-top.rst   | 1 -
 Documentation/tools/rtla/rtla-osnoise.rst       | 2 +-
 Documentation/tools/rtla/rtla-timerlat-hist.rst | 2 +-
 Documentation/tools/rtla/rtla-timerlat-top.rst  | 2 +-
 Documentation/tools/rtla/rtla-timerlat.rst      | 2 +-
 7 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/tools/rtla/rtla-hwnoise.rst
index fb1c52bbc00b..1ed4ceeb4660 100644
--- a/Documentation/tools/rtla/rtla-hwnoise.rst
+++ b/Documentation/tools/rtla/rtla-hwnoise.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 ============
-rtla-hwnoise
+rtla hwnoise
 ============
 ------------------------------------------
 Detect and quantify hardware-related noise
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index f2e79d22c4c4..c15ab9be07e9 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -1,6 +1,6 @@
 ===================
-rtla-osnoise-hist
 ===================
+rtla osnoise hist
 ------------------------------------------------------
 Display a histogram of the osnoise tracer samples
 ------------------------------------------------------
diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index 5d75d1394516..464459e55a17 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -1,5 +1,4 @@
 ===================
-rtla-osnoise-top
 ===================
 -----------------------------------------------
 Display a summary of the operating system noise
diff --git a/Documentation/tools/rtla/rtla-osnoise.rst b/Documentation/tools/rtla/rtla-osnoise.rst
index c129b206ce34..8a2e0504d737 100644
--- a/Documentation/tools/rtla/rtla-osnoise.rst
+++ b/Documentation/tools/rtla/rtla-osnoise.rst
@@ -1,7 +1,7 @@
 ===============
-rtla-osnoise
 ===============
 ------------------------------------------------------------------
+rtla osnoise
 Measure the operating system noise
 ------------------------------------------------------------------
 
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index 057db78d4095..84ab9f542ebb 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -1,6 +1,6 @@
 =====================
-rtla-timerlat-hist
 =====================
+rtla timerlat hist
 ------------------------------------------------
 Histograms of the operating system timer latency
 ------------------------------------------------
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 1b7cf4e3eafe..8be4ccaff898 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -1,6 +1,6 @@
 ====================
-rtla-timerlat-top
 ====================
+rtla timerlat top
 -------------------------------------------
 Measures the operating system timer latency
 -------------------------------------------
diff --git a/Documentation/tools/rtla/rtla-timerlat.rst b/Documentation/tools/rtla/rtla-timerlat.rst
index 44a49e6f302b..eceb3a16af08 100644
--- a/Documentation/tools/rtla/rtla-timerlat.rst
+++ b/Documentation/tools/rtla/rtla-timerlat.rst
@@ -1,6 +1,6 @@
 ================
-rtla-timerlat
 ================
+rtla timerlat
 -------------------------------------------
 Measures the operating system timer latency
 -------------------------------------------
-- 
2.41.0

