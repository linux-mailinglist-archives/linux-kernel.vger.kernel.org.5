Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F224C7BE3E2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376307AbjJIPGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjJIPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:06:49 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B0AA3;
        Mon,  9 Oct 2023 08:06:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0CFFE1BF204;
        Mon,  9 Oct 2023 15:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696864005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tCB7PBjPghhtGGaMQSET+YPO1C+yT+1TK7jvy0WeIO8=;
        b=WW5SOPBZrrGbuhivAx3X3wkx7ln4q7mmk70oHfbr054HS82qeeZmD3teMCpYqabVZaATMK
        zstXDb8/cgR1zoYE09ljPFVUKgZyGHbu4U1JV1bSVHJ28K/CzZ/b5QYMp234eJAHbBllAS
        v3EZ0uUbbzj/PxwflmvX3sz9c5UYuY/WSdt/fC6hDTYUn8aVh8TKeAHeXTfhXmH+OyhfwU
        C1XJEv0VFAn7A3f9QPQ3W9+8XOw99A59t0uJSW1Z0w9CSdmdMWQHHKkCbDR02XWpT3IT3p
        Y73mBeNlcM493saoGFPij3HMOm15T7Wc9wrMcxnBLSEt0LVpOHBbAbGcEQbLXQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 11/11] MAINTAINERS: Add entry for Mobileye MIPS SoCs
In-Reply-To: <721f56db-8e36-44aa-8984-48cdbcdc271d@app.fastmail.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-12-gregory.clement@bootlin.com>
 <721f56db-8e36-44aa-8984-48cdbcdc271d@app.fastmail.com>
Date:   Mon, 09 Oct 2023 17:06:43 +0200
Message-ID: <87mswrbzss.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Wed, Oct 4, 2023, at 18:10, Gregory CLEMENT wrote:
>> Add Vlad, Th=C3=A9o and myself as co-maintainers for the Mobileye MIPS
>> SoCs.
>>
>> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>>  MAINTAINERS | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 90f13281d297..6aedeab5f07c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14423,6 +14423,18 @@ W:	http://palosaari.fi/linux/
>>  Q:	http://patchwork.linuxtv.org/project/linux-media/list/
>>  F:	drivers/media/dvb-frontends/mn88473*
>>=20
>> +MOBILEYE MIPS SOCS
>> +M:	Vladimir Kondratiev <vladimir.kondratiev@intel.com>
>> +M:	Gregory CLEMENT <gregory.clement@bootlin.com>
>> +M:	Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> Is Vladimir's @intel.com address going to stay valid in the
> future? I would have assumed that after the spin-out, all
> remaining developers working on eyeq would go back to a
> mobileye address.

Until recently it was an intel address but now the mobileye one is
available, I will update it.

Thanks,

Gregory

>
>      Arnd

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
