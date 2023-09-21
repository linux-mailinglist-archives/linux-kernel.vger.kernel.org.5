Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7667A966C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjIURCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjIURCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:02:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384A9CEA;
        Thu, 21 Sep 2023 10:01:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ACEC4E76B;
        Thu, 21 Sep 2023 14:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695306579;
        bh=9tvStd1eYmAawVVbsDie2tHpFeVMdoFAdNDNydF7QGQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=auje0uEUE+m+3g2jH1IuoGo/I0FUvd82445GiTAR/DKsQo1/fasU4p9KGyhJGfrFE
         pWAi6ckAxzjwY/scpaEirq/9D+9BiIXEpXPSV4RSIhq3vcGMRisVhxOTnbhjDHlBrQ
         qg+MR3Bx/jF9jhdb4hxEybOki6fx/onS1eehXeqGiirYCUigvmYfO3k+hYQcRO8tWv
         NzId44tjuUKuIQNYd6obQzKHjfF/c5i2rtyGP+7B8B3agztfFTTUeWw2YpWinEIAvH
         sfCxjqdAzU+d1HsF52XCeRJUxfho9A+PBQuBYcKrSkN8U7P4A1oBVf9E8n8B6n2Tqh
         qhGQhWOoZLTfA==
From:   Vinod Koul <vkoul@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Nitheesh Sekar <quic_nsekar@quicinc.com>
In-Reply-To: <20230904063635.24975-1-quic_nsekar@quicinc.com>
References: <20230904063635.24975-1-quic_nsekar@quicinc.com>
Subject: Re: (subset) [PATCH V4 0/4] Enable IPQ5018 USB2 support
Message-Id: <169530657502.106263.11564908217674550453.b4-ty@kernel.org>
Date:   Thu, 21 Sep 2023 16:29:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 04 Sep 2023 12:06:31 +0530, Nitheesh Sekar wrote:
> This patch series adds the relevant phy and controller
> DT configurations for enabling USB2 host mode support
> on IPQ5018.
> 
> Tested with a USB Mass storage device.
> 
> Depends on:
> Link: https://lore.kernel.org/linux-arm-msm/20230831030503.17100-1-quic_nsekar@quicinc.com/
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: phy: qcom,m31: Add IPQ5018 compatible
      commit: 76bf09e08667f21bc3d1a8857f542c1ee54d9667
[2/4] phy: qcom-m31: Add compatible, phy init sequence for IPQ5018
      commit: 241da15bd783fd2ae3b2f16817d802102590aa0d

Best regards,
-- 
~Vinod


