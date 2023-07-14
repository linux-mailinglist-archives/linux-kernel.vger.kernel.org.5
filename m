Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C0875314B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjGNFbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbjGNFav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:30:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D338CE;
        Thu, 13 Jul 2023 22:30:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA8A761C27;
        Fri, 14 Jul 2023 05:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E86C433CA;
        Fri, 14 Jul 2023 05:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689312648;
        bh=OO3aJGSLrJlHxzbJ/RAQsyOAvgpnOxQpufn7Eu9OMqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPRNr0W04D1o76be8JFHxLxu6Ix2T2izn8FdR86uJRf+ZOg9//wXchVpRa/i+OaeR
         tB6x1+PTZMubhCqxVZXFl7gWTSo7WPzPd8PkFqOCPr/r26FVNloGN2efpe85nSymRg
         cqzDXYTLtP+3fxVTkImCT9SQcIYxSA/WM5gvgaFym+E20nDkwSyL/fteoWduYcqc93
         HJjtqnnTaDQvq3aJN7CWxsd9JS4DiaLNhpRNcCGF1s2H6/LPAk1GQC7Xc61NRh5Rqa
         ymm741oXZ0M0/TVCki0XJ326VxUsdq4xx8me3D+V0WZWeoMeOxNS08P8/iAhaR90yD
         jFotBQx04DB2Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     quic_varada@quicinc.com
Subject: Re: (subset) [PATCH 0/1] Add cpu cooling support for ipq9574
Date:   Thu, 13 Jul 2023 22:34:03 -0700
Message-ID: <168931284128.1538684.6561992585360702369.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713083101.971525-1-quic_ipkumar@quicinc.com>
References: <20230713083101.971525-1-quic_ipkumar@quicinc.com>
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


On Thu, 13 Jul 2023 14:01:00 +0530, Praveenkumar I wrote:
> Attached patch adds cpu cooling support for ipq9574.
> 
> Praveenkumar I (1):
>   arm64: dts: qcom: ipq9574: Add cpu cooling maps
> 
> arch/arm64/boot/dts/qcom/ipq9574.dtsi | 61 +++++++++++++++++++++++----
>  1 file changed, 53 insertions(+), 8 deletions(-)
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: ipq9574: Add cpu cooling maps
      commit: 752f585805c559e7c990e7d23e49d03167065761

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
