Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5737B255E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjI1Sf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjI1Sf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:35:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BDF1A1;
        Thu, 28 Sep 2023 11:35:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D123C433C7;
        Thu, 28 Sep 2023 18:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695926125;
        bh=kRFAwJeerof4Xj/Rqpb/7KVVGbGiS82bsy23rOFcCBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpHtj4087rKeHQLPj+FQ8XNBIAQHRNj9h2vBN0A+kuPX6ON0t7JWcysR3NLYGpZpv
         IBSLmR3gfLm7qEyFGPKJBNJvzD5UGjGQfjlg4Gnt84ilSfD5eUn+EDHRBQdMCAlHsA
         GXHd4DRtERaQTIcE67G43tJ2Y3Uieob25sVWjssfuzkTiveSg1PzwJXTLuUg6Phqgb
         TbkAtOFuJirbyLjpjtp4MqqkDFnPaPt+CGscmTFGdjY49s8IgQbjleHs14m8dnW+sv
         LCHJ+ALNL+ClD2l795B95g0WFkvcF8PXlSxvN2I9NQUB+JQGdiryvEsUqHdErq5V26
         lpeBOSQN7WZtg==
Received: (nullmailer pid 1034755 invoked by uid 1000);
        Thu, 28 Sep 2023 18:35:22 -0000
Date:   Thu, 28 Sep 2023 13:35:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     tali.perry1@gmail.com, venture@google.com, joel@jms.id.au,
        devicetree@vger.kernel.org, avifishman70@gmail.com,
        linux-kernel@vger.kernel.org, j.neuschaefer@gmx.net,
        linux@roeck-us.net, benjaminfair@google.com,
        openbmc@lists.ozlabs.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, yuenn@google.com, jdelvare@suse.com,
        andrew@codeconstruct.com.au, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: hwmon: npcm: Add npcm845 compatible
 string
Message-ID: <169592612186.1034699.3436968254453890969.robh@kernel.org>
References: <20230927173850.103435-1-tmaimon77@gmail.com>
 <20230927173850.103435-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927173850.103435-2-tmaimon77@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Sep 2023 20:38:49 +0300, Tomer Maimon wrote:
> Add a compatible string for Nuvoton BMC NPCM845 Pulse Width Modulation (PWM)
> and Fan tach controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

