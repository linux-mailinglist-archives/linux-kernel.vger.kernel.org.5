Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B437CB24C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjJPSWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbjJPSWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6598A2;
        Mon, 16 Oct 2023 11:22:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B64C433C9;
        Mon, 16 Oct 2023 18:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697480526;
        bh=SPQHicwszrYG4iAv02EGjtDfKtjCM6t2EONlIMyuy9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdgUttbPyZRkWy1G073UelRPmbxGTLaLIWvro6JPSaNj4FukKSE8bKi4Td/bmikc+
         VWs8PURR/b1rxD121kqExml3GlfBC/vZP5mG0R2Y6EwQhkV22XdqOWVI2GieilSgdm
         T7EgECPwqIie8La9B3R+pLyoeKK0yqbi76aWl+7crQrGufdmVdoUfduEcGhDdH2AwQ
         jG9rNLzVOgxZuuOAI6jqaxeIkmS/VyOakaPOG8DVlnFzN11Ay+HSZ34LQIwgd/ZHFW
         d+pYesrg8uuo6WeQvn7/mAC3QO1Wl2gr9ASE085GXd1WCRMtn7t9rfjE5cbtEuwU3J
         wsr5OfmLqwcLw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Add ports subnodes in usb/dp qmpphy node
Date:   Mon, 16 Oct 2023 11:25:48 -0700
Message-ID: <169748074958.1245023.9455563372415056854.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-sc7280-qmpphy-ports-v2-1-aae7e9c286b0@fairphone.com>
References: <20230929-sc7280-qmpphy-ports-v2-1-aae7e9c286b0@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 29 Sep 2023 14:51:22 +0200, Luca Weiss wrote:
> Add the USB3+DP Combo QMP PHY port subnodes to facilitate the
> description of the connection between the hardware blocks.
> 
> Put it in the SoC DTSI to avoid duplication in the device DTs.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Add ports subnodes in usb/dp qmpphy node
      commit: 2278b16f12a9cc33b95a980e05d4d8f3f8e0abfa

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
