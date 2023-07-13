Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15F6751C12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjGMIrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjGMIq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:46:58 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED0510E2;
        Thu, 13 Jul 2023 01:46:54 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F86960007;
        Thu, 13 Jul 2023 08:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689238012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ell+mVmA6ajwidpFJ1+ZJ6N/R8tB9j3ZsQpcDXv+1c=;
        b=kfxchL5ZmCB0gI018C/sYSV2a89k6k7tjP3IcKp6T5lwuTze2NVTWS5Vkb1PpAJWJ/4mse
        y90WjUUNm3/S+G6YAZy2sS/0PtOKPDsYQlrcbKmLQnQV+3+qxMEbA52mmSeHZzVHg/ubaf
        uKtMwV9btCP5ztMBbM9QYZuxK+n5moY/SwJheqMp3DDJteSUrUbl3j3SlP3+x3GlmRHE6N
        1Kp8YBIs4ZxLfgd7FaMsHM7mIk+BeqyUYg5kH/WeqGL57vpmLx/W5JoN2uCbT1Ha6DKyIj
        8jq6DjbhcJN0USp7jG1GjVmOnQy77dj78/xKSe83cp/wv0czD+MOdA53+euO9Q==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: marvell: add missing space before {
In-Reply-To: <ca9f2c62-5faa-45d7-afbe-9ace5dc949cd@lunn.ch>
References: <20230705150018.293752-1-krzysztof.kozlowski@linaro.org>
 <20230705150018.293752-2-krzysztof.kozlowski@linaro.org>
 <ca9f2c62-5faa-45d7-afbe-9ace5dc949cd@lunn.ch>
Date:   Thu, 13 Jul 2023 10:46:51 +0200
Message-ID: <87r0pc2o78.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Lunn <andrew@lunn.ch> writes:

> On Wed, Jul 05, 2023 at 05:00:18PM +0200, Krzysztof Kozlowski wrote:
>> Add missing whitespace between node name/label and opening {.
>> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>     Andrew

Applied on mvebu/dt64

Thanks,

Gregory

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
