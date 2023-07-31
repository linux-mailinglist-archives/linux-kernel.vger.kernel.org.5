Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5688276A525
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjGaXuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjGaXt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:49:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2585D1735;
        Mon, 31 Jul 2023 16:49:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 817C661342;
        Mon, 31 Jul 2023 23:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5ECC433C9;
        Mon, 31 Jul 2023 23:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690847388;
        bh=8nKZwdlEB6v5OrYnBpVCYHlFYi2NqtgFw/lLzSPEIVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rSy+972wAlv3IEAeTFqhiHtCXXVRCWMSpKpJC/zZQzWzXYPeBQRAOkcIThUBPrJJN
         X3ZRNYN0nnmsTR2bDScWfNsmV0kJI2+tTdBLvnN82Sswp7ALfFL8bmT8BUmH2KkbCg
         Oci6hoziCIQOcLKAUHBC1xzPlgGAHEBCQaSKTWXke90fY7Pci0vMz0My7j25rUJRhW
         z8vh780367BHzdI7dZhj0sb4b4JcJjg4Qar77mdwPnIsYwNtmC7TJ1TJT/8dZ+u7dP
         PMLN2h+XokTGR0NoeMmI3omErd3JkvmFLfY2MXFE4pl4LC5spURADdAmjU2Zzbnl8e
         7LKSh0JtlLpUA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Tengfei Fan <quic_tengfan@quicinc.com>
Cc:     quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/6] soc: qcom: Add support for SM4450
Date:   Mon, 31 Jul 2023 16:52:46 -0700
Message-ID: <169084756383.3010488.16009123318989557949.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731080043.38552-1-quic_tengfan@quicinc.com>
References: <20230731080043.38552-1-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Jul 2023 16:00:37 +0800, Tengfei Fan wrote:
> This series adds CPU, SoC and board compatible support for SM4450.
> 
> 

Applied, thanks!

[2/6] dt-bindings: arm: qcom: Document SM4450 SoC and boards
      commit: 2b1fd18fe5f9382409d4c881d28bca9693f361a1
[3/6] arm64: dts: qcom: Adds base SM4450 DTSI
      commit: 7a1fd03e7410a8413e6140d967d66c624ddec690
[4/6] arm64: dts: qcom: Add base SM4450 QRD DTS
      commit: a5de9bc61181cd65df0170ba8c855b6be650c1e8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
