Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7597751C13
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjGMIrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjGMIrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:47:05 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F34219A6;
        Thu, 13 Jul 2023 01:47:04 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EC85E20004;
        Thu, 13 Jul 2023 08:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689238022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4AClv/YhZ1qmlDZojyXt9vNkdOPot+nXyt4J17vKMSU=;
        b=m4rcMWkm/+idR2xAPAYEQ0igQ3FHTcN4LTsGYvH4H93LRIdPQYN2kqqBdl4YE3jAzgMBrh
        cCysfJ0pAkhS2RmfBv5vi9yk/R3SV8vWlS6bj82W/Cw7cJz/2siYz6ueCPYWO5hz/73/rg
        8qrgDm9nlZ+F475AtgSRcha6wMLd4RHydUmjU36iFkdABEcg7rNPo++lAEUKwqTEHbjJUG
        XD1hsBjv5ko2yXNucOeFpktoywKhMh3VixJV1IlA4lZtKowRvddGsoYWTb8ySqdKu+xRRU
        4++3I8OYKv/7PCpMBh4F8te83+Pm9Cm3+THRuJQ6qjwE+YMUo8LZ5VRIvUqMSw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: marvell: add missing space before {
In-Reply-To: <7e458907-1961-4596-ad8e-0a20a745b501@lunn.ch>
References: <20230705150018.293752-1-krzysztof.kozlowski@linaro.org>
 <7e458907-1961-4596-ad8e-0a20a745b501@lunn.ch>
Date:   Thu, 13 Jul 2023 10:47:01 +0200
Message-ID: <87o7kg2o6y.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Lunn <andrew@lunn.ch> writes:

> On Wed, Jul 05, 2023 at 05:00:17PM +0200, Krzysztof Kozlowski wrote:
>> Add missing whitespace between node name/label and opening {.
>> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>     Andrew

Applied on mvebu/dt

Thanks,

Gregory

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
