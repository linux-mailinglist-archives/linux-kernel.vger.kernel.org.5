Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075397A714D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjITDzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjITDzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:55:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A85AEC;
        Tue, 19 Sep 2023 20:55:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E65C433CA;
        Wed, 20 Sep 2023 03:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695182103;
        bh=0OfGAgj9B1M3uxCBGkPH9BLHjbYOKxkiMUU8NAeOGHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJwm0YAYHIjHSxVZvAIEg3D0lNLRhTwOD09zYRWASl2ua1KazmYXstWULRe4iRmCT
         dQjUY3jvMWUsEURYOph4hswyF2vb3lGSuVNrw++XbPmdX/QBovu063VFyxccXoQY5W
         UA4HdBW0+yBIsRySYgf2h4TPBlNUdS8WBOku3O7pjWAUXtVT9bbIxVoWltFOj/tfJr
         BwdhQzMUP0dxSzARouFtwrgMO3lV5PClElRp0xLcqqEi50CCly3x1MBj32iMvyfSjA
         Gmy81cODhCZz+tOy/ZHMGAM7ljZVqVmrIsIX+MO+QyO0TJgtjUku8Ag9EUdbVwFrz8
         RjUca/Y5KTKGQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-samsung-j5-common: Add accelerometer
Date:   Tue, 19 Sep 2023 20:58:54 -0700
Message-ID: <169518233720.1055386.10935054486033154435.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904123123.2593-1-linmengbo0689@protonmail.com>
References: <20230904123123.2593-1-linmengbo0689@protonmail.com>
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


On Mon, 04 Sep 2023 12:35:03 +0000, Lin, Meng-Bo wrote:
> J5 and J5X have ST LIS2HH12 accelerometer.
> Add support for it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8916-samsung-j5-common: Add accelerometer
      commit: 922c031eb2b4897cc01f4159f7325a2dcd8d6c7e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
