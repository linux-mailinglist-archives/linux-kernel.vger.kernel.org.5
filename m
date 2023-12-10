Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3970180BE23
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 00:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjLJXVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 18:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjLJXVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 18:21:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A7AF2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 15:21:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A15C433C7;
        Sun, 10 Dec 2023 23:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702250478;
        bh=0SwR15QKyjc4lI66xJvZglqK8JbLrcKKmOUbpXT8Ayo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ttK2msjgOje+AoxFh73cyyDL/lrykNpcUpeXiFWJMvx8Za1tDvJSg0vKx1kD9WGGK
         qn2jNIJQp7eGXUIwuGOh6fYFCD+EiXj+IxSGKvwoEifkwhmQfIYNivBNpgMWRjsh/O
         HLJIROmPDGIllA1ZB4PZSD9CK13aNuisPFY5UoVS/f+Dtldj68giHvOtyNdyw8nJSE
         7AAlxr0i//sdJmy3d0jsZpxocv1/tFwTrmQFXXKBHwJG++5di3+m4xbacyqEGE3voM
         Pw+AZL33Vho3chOCavh7kG98m81p/99b0KmkgNYsrgZFpvHHiOifIXrJf+DYf4yF7j
         tkcLb2KHoBRtQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] Add GPU support for MSM8226 (Adreno A305B)
Date:   Sun, 10 Dec 2023 15:25:39 -0800
Message-ID: <170225073880.1947106.13814955780498135531.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130-msm8226-gpu-v1-0-6bb2f1b29e49@z3ntu.xyz>
References: <20231130-msm8226-gpu-v1-0-6bb2f1b29e49@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Nov 2023 21:35:17 +0100, Luca Weiss wrote:
> Add the necessary bits to bring up the GPU on msm8226.
> 
> Tested on apq8026-lg-lenok.
> 
> 

Applied, thanks!

[3/3] ARM: dts: qcom: msm8226: Add GPU
      commit: fc209f869310776c437daba478246df64d82c38b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
