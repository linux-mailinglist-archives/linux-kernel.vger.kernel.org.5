Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98447D4CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjJXJoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjJXJeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:34:02 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC6F1BE7;
        Tue, 24 Oct 2023 02:33:24 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 5F862403C2;
        Tue, 24 Oct 2023 14:33:22 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1698140002; bh=vvlsPglAafPbW2BKSO9r1EkmmFaEoY05iLxuBLOPVXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XS4nY1Uep/9630q6iXI4qyhdoYuIXQ0uf8TehNa5FnUN7+O+mBS4jpRPQxQv+PkM5
         NvVzRpvl6iio/4OVeQziKjlVLNVnJHiSJS90JJC/t4rSmQH7Dr4fvzsQxNejXogxPZ
         9UpcnfksAZKQVIgW5tHDsD6FoaiDyBXtxZiScbW4aLLx74eMOBJX+TuHGEw8gMH7uT
         SfBeSHwvVDjGsnR1XeBs4TjkQRdwzo4iuk1ssaQf6GNyqzx3nw2L05YR+ctfUDl4Jj
         Qb7JfzLygNu2u9k5urZjR/rtPPlW1bpTIy0HDJ1ugYhfcLkn2HFjiLeu//AUlj/Ieb
         yFAFteDwgtwgw==
MIME-Version: 1.0
Date:   Tue, 24 Oct 2023 14:33:21 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8916-longcheer-l8150: Add
 battery and charger
In-Reply-To: <72a9ce0f-1bdf-4d97-a9f6-1aba532b0f18@linaro.org>
References: <20231023-pm8916-dtsi-bms-lbc-v2-0-343e3dbf423e@trvn.ru>
 <20231023-pm8916-dtsi-bms-lbc-v2-3-343e3dbf423e@trvn.ru>
 <72a9ce0f-1bdf-4d97-a9f6-1aba532b0f18@linaro.org>
Message-ID: <a4adb159c5afb3a16d4b181a3c9afcbc@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Dybcio писал(а) 24.10.2023 13:33:
> On 10/23/23 08:20, Nikita Travkin wrote:
>> Longcheer L8150 doesn't have any dedicated fuel-gauge or charger,
>> instead making use of the pmic hardware blocks for those purposes.
>>
>> Add pm8916 bms and charger, as well as the battery cell description
>> that those blocks rely on.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
> Doesn't apply on next, please rebase.
> 

Ah, great, I guess I sent the series just a bit too early
and the -next didn't update yet...

I think at this point I might as well just wait for the -rc1,
will probably save everyone a bit of trouble...

Nikita

> Konrad
