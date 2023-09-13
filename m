Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A49C79E566
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbjIMKzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbjIMKze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:55:34 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3CD1726;
        Wed, 13 Sep 2023 03:55:30 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-76f0807acb6so419101985a.1;
        Wed, 13 Sep 2023 03:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602530; x=1695207330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HseJUOixWLxiX/GtlrIAvJAEnfu8kx8mRj8kJhsQL/k=;
        b=rFQGzLSK8+MU8TfVv0oWnEti0K7naNAtNX+EsgiyB5gRM/5cJUMI4GxUtWxe9vptDy
         QRjwHbh/IAUVnBRGmAYvgnYCdeuobt74cfjvRyx9ZB0hQ5Me+dMHvw1EoeijCDX09tdO
         HiW9AnBPpMnljVG+svXniqX0bBrZFByuwn8I6iRukPpdlJuf5cUKBqQTJqo5LxQ+Hfds
         Bve1BYTfRjBMds9wfUmjhJYpo05reY/o88kS7uUtSD4vRAK3AZ6W0rNuiUFcbKsmntSu
         YQXO2rMZZf7IUTxqnFrSyKXrfW7U/n8KTWWoTj+7UvjFx7DsN7tbZF5LcuJzD/OZOPMW
         dVZg==
X-Gm-Message-State: AOJu0Yzb70YSnQqYul9i3Lyc8DDGORL1/T44QucdVHvjdaPuqJAAQ73q
        Wcuwxmp45cAbmCwKu9gBl+M=
X-Google-Smtp-Source: AGHT+IEggUoDJy/CLhavcac41098wRydbSBa6L3K7VJOdlQ590WtSzyCpIk2nUY7/4Dy7Pp4cRJPyg==
X-Received: by 2002:a05:620a:eca:b0:76f:1846:2f44 with SMTP id x10-20020a05620a0eca00b0076f18462f44mr1687467qkm.0.1694602529791;
        Wed, 13 Sep 2023 03:55:29 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:1a3:cb84:45fc:12dc:6d10:9889])
        by smtp.gmail.com with ESMTPSA id d2-20020a05620a166200b0076825e43d98sm3841068qko.125.2023.09.13.03.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 03:55:29 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH] docs: move leds under section Human interfaces
Date:   Wed, 13 Sep 2023 13:55:18 +0300
Message-ID: <20230913105519.675183-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

from uncategorized list

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/subsystem-apis.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index 90a0535a932a..930dc23998a0 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -35,6 +35,7 @@ Human interfaces
    sound/index
    gpu/index
    fb/index
+   leds/index
 
 Networking interfaces
 ---------------------
@@ -70,7 +71,6 @@ Storage interfaces
    fpga/index
    i2c/index
    iio/index
-   leds/index
    pcmcia/index
    spi/index
    w1/index
-- 
2.41.0

