Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40DA773F5D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjHHQqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjHHQpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:45:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B971B5584
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:56:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99cdb0fd093so312055066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510156; x=1692114956;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=150u+BhP6BAs6NxISp4qHIiyuoHr72iFboBWpKqesUg=;
        b=SFKWmMW4ECYSAAMr2SkJ/Y1oVvXuzuvm+2kg27kpDMJPCyuNsK2eZB5y6vQnxEpva9
         MaNkky6iDjs5wwuSgRJeV4Niwv01BlOJ0u8vZsdSQJNUfm8gueWpUMBtz8TqDQ/LWJn7
         /1gqz/4vDcKxBWgNsB9umPtrRBZWwucpreeJ6Q/5xu5LTqUQ7gks8hdg4FvKpXjgxCVp
         wnkTA1l0aAW2xwW4xmp2PM9/3v1yOGfI6DKxK/LAKDb5huDxCcq4eQMhyo9eViogF32D
         pDPrEsc0XQAqLaZ/htewWkZDrGn8Isj/zYBtaWN2ZV0gAz/0VNJfbl+HXa6UnIUxq6Fu
         RO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510156; x=1692114956;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=150u+BhP6BAs6NxISp4qHIiyuoHr72iFboBWpKqesUg=;
        b=Q6gGLEQrePqqwNIS9MIXvgJWhq8oyUSuZchnPaICX67uXDaEoxeb/+SbMQR1D5KN3U
         H6/I1teuKavQFOCWLfM3emaAFmQ/9310q+5fa2jb+viyC3F5u0o3clHsDxuSGhXyEWnX
         Y3sn7WcNtDWMx1YKy+eEk0BIDVAXyBZydgQvKOSZfO5PJI+uS2fOffZ5JN9yToMAklzL
         INLId8Rp9+WEzs31wZSpqNm71eKvLQjuFYifuJi9kcqR0l2OT3ZDoROthBnG7n3sWOu1
         yqiLibqK6e8Gih+gxOU7JYBCFK66P1EI0YLDSS+V+I+Agqg90TFbCA1ZAlHgoBm9DC4G
         iLtw==
X-Gm-Message-State: AOJu0YzVMsC4f5cc1xsJJr/eBUN6rAvDV+V1mPk2p4IVH90ojRDI6hPA
        FON5rYYDU/G2OghaeR/PTWia+z8OiGnBnLSI/Hs=
X-Google-Smtp-Source: AGHT+IFjOxwT+CSt1CS60ZwMIloyErxqwz//Hr9K+lx3WcJtISD2rmCwVBfVqbazUt7D1JRPYcoWIg==
X-Received: by 2002:a05:6512:3122:b0:4fb:987b:ec3c with SMTP id p2-20020a056512312200b004fb987bec3cmr7993527lfd.56.1691488166692;
        Tue, 08 Aug 2023 02:49:26 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id v14-20020ac2592e000000b004edc72be17csm1813263lfi.2.2023.08.08.02.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:49:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 08 Aug 2023 11:49:19 +0200
Subject: [PATCH] MAINTAINERS: Update Konrad Dybcio's e-mail address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-topic-maintainers_korg-v1-1-e61c2bc98b2b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJ4P0mQC/x2N0QrCMAxFf2Xk2UJdUau/IiJtF7fgTEcyRRj79
 4U93Idz4XAWUBRChVuzgOCPlCobHA8NlCFxj446Y2h9G3z00c11ouI+iXi2oejzXaV3XQn5jDF
 cy+kCJuek6LIkLoPp/B1HOyfBF/332v2xrhuthhktfQAAAA==
To:     linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691488165; l=1267;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vMpzcCDAb75QhHPPNPls71TKzNwpHNQ020eqmLgjbAQ=;
 b=OGe7Ti5YDWSwjzm0n5v8Hgew8pktx6u6dKuV61+3DvgaE8rWb/b5mruxvms5p5fQgqIFaAirv
 rQp7YkWVTOMCBzh6h9vEfjy8nxprthNMfPz8qIsExKdDhFzo8HWgl3d
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been quite a while since I obtained a @korg email, it's high time
to update the maintainers entry to reflect that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 84944571d1b1..b26ed5b87dfd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2525,7 +2525,7 @@ F:	arch/arm64/boot/dts/qcom/sdm845-cheza*
 ARM/QUALCOMM SUPPORT
 M:	Andy Gross <agross@kernel.org>
 M:	Bjorn Andersson <andersson@kernel.org>
-M:	Konrad Dybcio <konrad.dybcio@linaro.org>
+M:	Konrad Dybcio <konradybcio@kernel.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
@@ -17618,7 +17618,7 @@ F:	include/uapi/drm/qaic_accel.h
 
 QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER
 M:	Bjorn Andersson <andersson@kernel.org>
-M:	Konrad Dybcio <konrad.dybcio@linaro.org>
+M:	Konrad Dybcio <konradybcio@kernel.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained

---
base-commit: 71cd4fc492ec41e4acd85e98bbf7a13753fc1e03
change-id: 20230808-topic-maintainers_korg-dc3b6e839c57

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

