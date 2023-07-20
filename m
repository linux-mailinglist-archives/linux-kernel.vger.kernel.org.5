Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B5075ABA6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjGTKHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGTKHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:07:20 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C06B4;
        Thu, 20 Jul 2023 03:07:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A10E5E0003;
        Thu, 20 Jul 2023 10:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689847637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U2lE7mwordinYe+5niCuJ5wlDGxw7oONgO884Wc+CiA=;
        b=eblnY3pfpkUCjGYxy+SowcVhvuzzW61JZrHxwG2VO0kjXR2cO9mJKFPCI1FBcdCjlv44ON
        x91Ikr5/ab/tBnVXpM5n2xQ3bxLt81mXvpkkHeU26gg5dpkZ44jVXcNXBWXZd4s3AgemwT
        AROHWFO5HPs8flsnqlQgkiB96+OtFtAtVo+lHLgpLybad36apDiHb8cA120J8CqlyLASKu
        HAgIG6rdKr8hvcOhHRZTzBgStjZn2y+p2a9ETqDGY3WsRtTPZrnLI+wN06GRJV9RKePusi
        11ZIWocnBKVkTmIzCYklRypkIPHHnWaURF5fI8A45WjpH9DquiiWW8qT+NgA2Q==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 1/2] media: doc: dev-encoder: Fixup whitespace before bold asterisks
Date:   Thu, 20 Jul 2023 12:07:01 +0200
Message-ID: <20230720100702.42803-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An extra whitespace after the asterisks prevents bold syntax parsing
and results in the asterisks shown in the (non-bold) title.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 Documentation/userspace-api/media/v4l/dev-encoder.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/dev-encoder.rst b/Documentation/userspace-api/media/v4l/dev-encoder.rst
index aa338b9624b0..c82d27689c08 100644
--- a/Documentation/userspace-api/media/v4l/dev-encoder.rst
+++ b/Documentation/userspace-api/media/v4l/dev-encoder.rst
@@ -233,7 +233,7 @@ Initialization
    :c:func:`VIDIOC_S_PARM`. This also sets the coded frame interval on the
    ``CAPTURE`` queue to the same value.
 
-   * ** Required fields:**
+   * **Required fields:**
 
      ``type``
 	 a ``V4L2_BUF_TYPE_*`` enum appropriate for ``OUTPUT``.
@@ -284,7 +284,7 @@ Initialization
    the case for off-line encoding. Support for this feature is signalled
    by the :ref:`V4L2_FMT_FLAG_ENC_CAP_FRAME_INTERVAL <fmtdesc-flags>` format flag.
 
-   * ** Required fields:**
+   * **Required fields:**
 
      ``type``
 	 a ``V4L2_BUF_TYPE_*`` enum appropriate for ``CAPTURE``.
-- 
2.41.0

