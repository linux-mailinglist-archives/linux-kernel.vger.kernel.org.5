Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201EA808BC1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443466AbjLGPZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443452AbjLGPZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:25:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1312510C2;
        Thu,  7 Dec 2023 07:25:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33CFC433C7;
        Thu,  7 Dec 2023 15:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701962756;
        bh=QSRLw7yztCghjyxb/KELP29iYZGlYvVKvP/F2T64Jww=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jLNIWoTMMlZNrMRCUjmXid2FCoRKOegMarVWk3xLK4aTFV6FBlgv5y9ie8gZ3gbjf
         HVy1/YRb6I6hDXuOKp/2fMWHBZKzcwJZzNkVUiXibUjyVLsXfjZaOp0/uPsLciony/
         bPDSlMOC4YH6hhKUJ0YA54GWz29VI+hQKM339jK2I8ACK55mC2wtoIv/CAiBg0wesQ
         IjgWPLDNFODIZUsAlrxz91CR4kOzWxn4SfQFXsbJ6YeCvaZ/Gc1rsHDl87NCLtDxLa
         Hyww8vRbvCLV66RcyTFs6hRxZws4Kh4tjak3En96dfuEfX5vKidCiRhJjyE24K2iP1
         hcqEppM2IsqTA==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        inux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231130171940.12391-1-johan+linaro@kernel.org>
References: <20231130171940.12391-1-johan+linaro@kernel.org>
Subject: Re: (subset) [PATCH] dt-bindings: leds: qcom,spmi-flash-led: fix
 example node name
Message-Id: <170196275366.99959.4254922896810354041.b4-ty@kernel.org>
Date:   Thu, 07 Dec 2023 15:25:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 18:19:40 +0100, Johan Hovold wrote:
> The led controller is a child of an SPMI PMIC, which in turn sits on an
> SPMI bus.
> 
> While at it, add some newline separators to improve readability.
> 
> 

Applied, thanks!

[1/1] dt-bindings: leds: qcom,spmi-flash-led: fix example node name
      commit: e9a3374e5c545e5eade4623098b958d2f4073455

--
Lee Jones [李琼斯]

