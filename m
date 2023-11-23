Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B227F651F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345402AbjKWRSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345475AbjKWRSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:18:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E4910D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:18:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3B2C433C7;
        Thu, 23 Nov 2023 17:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700759916;
        bh=VfLbIw4uft5SCXKloHizPrPXh+pbMziShDpa3FrSeo4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gRGFbDODAHk+10czz+dGtRvfja+tbJwqvf7hVnCBZy9cLg1Lb2WREsxyLk6BsvGxk
         bcMo1D6CXY1tgd8nfb12lQyfgq4a/owNyRBHck8u4SWDkpmbLzzew69JQvIwAAiEEA
         jfCldkI8VsBDEQOOf8e3KD91eRZbaACwwTbE6uKRJudd1AS9Siv3DO3qMN3Abf1mrE
         inU8e8sbJ7w5tsib61s12NXwHAXeg+HSk5e5JUpwajhL35KItZM6FrkqAW86c4UoNe
         IQYEHEM+X0YdeLMIOXBYbe/a/gQMb/u4dE+2Hhbt4daFXjEFog17CeMzMd78NwL4uH
         yCKl9ytKEmBow==
From:   Lee Jones <lee@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231120-pm8916-dtsi-bms-lbc-v4-1-4f91056c8252@trvn.ru>
References: <20231120-pm8916-dtsi-bms-lbc-v4-0-4f91056c8252@trvn.ru>
 <20231120-pm8916-dtsi-bms-lbc-v4-1-4f91056c8252@trvn.ru>
Subject: Re: (subset) [PATCH v4 1/3] dt-bindings: mfd: qcom,spmi-pmic: Add
 pm8916 vm-bms and lbc
Message-Id: <170075991369.1460551.2059005870143755036.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 17:18:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 19:03:03 +0500, Nikita Travkin wrote:
> PM8916 (and probably some other similar pmics) have hardware blocks for
> battery monitoring and charging. Add patterns for respecive nodes so the
> devicetree for those blocks can be validated properly.
> 
> 

Applied, thanks!

[1/3] dt-bindings: mfd: qcom,spmi-pmic: Add pm8916 vm-bms and lbc
      commit: 95f44ef666a6504a7c75def89fffacb0ae4bf52c

--
Lee Jones [李琼斯]

