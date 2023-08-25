Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF097881F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbjHYIVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239756AbjHYIUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:20:42 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8958119AD;
        Fri, 25 Aug 2023 01:20:37 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 290651BF214;
        Fri, 25 Aug 2023 08:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692951635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s7m/4pQD3gCo/V071m4nl/HimDm8tCat76xxXDvmJYA=;
        b=J7moYxo990zjrNGVbGz9dyMSVVZAZHwGenTXVI2UQoCJpa3uiE73RzLpHB+htrM2DcO/eD
        ymITedzE/IvdtnqZnCIB88gU1ktv2TVVMmLbV1NRwlbDrygCgYZmN2r4YlRAwuaFWWh83j
        efMo1zMtXy412NGR/LTuxscqVvYCL1zD+X3COXWk1xuX3LbezfrVqg6cPByzLFIUZoU0kl
        kDpg+T+63ySmPMsLYaDJpuEClSrZ3pnwwpNTadCTt4N+zx1v5ukVMyiivMr8H+kZ2X100w
        zLMwlDpfYo0YoCJimbDkHLEc9VUVWbQDcJ3/G3w3uXT05EuiQsSlRiMwAC9I8w==
Message-ID: <f8ff7611-d8e8-d229-2b72-95e6b3ca951d@bootlin.com>
Date:   Fri, 25 Aug 2023 10:21:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dsa: marvell: add
 MV88E6361 switch to compatibility list
Content-Language: en-US
To:     airat.gl@gmail.com
Cc:     andrew@lunn.ch, davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        olteanv@gmail.com, pabeni@redhat.com, paul.arola@telus.com,
        richardcochran@gmail.com, scott.roberts@telus.com,
        thomas.petazzoni@bootlin.com
References: <add84df503df6b0bd3f572cd396dbde9da558eab.camel@gmail.com>
From:   =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <add84df503df6b0bd3f572cd396dbde9da558eab.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 8/24/23 20:49, airat.gl@gmail.com wrote:
> Is there an error? The new string include 6163 instead of 6361

I am afraid you are right, I made a dumb typo in the binding docs while
submitting 88E6361 support.
I have sent the corresponding fix to net, thanks for spotting this.

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

