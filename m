Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C862876B404
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjHAL4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjHAL4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:56:52 -0400
X-Greylist: delayed 1171 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Aug 2023 04:56:50 PDT
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989681722;
        Tue,  1 Aug 2023 04:56:50 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=6591099da3=ms@dev.tdt.de>)
        id 1qQnMH-00E6Gu-IY; Tue, 01 Aug 2023 13:16:09 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ms@dev.tdt.de>)
        id 1qQnMF-00DEmD-CJ; Tue, 01 Aug 2023 13:16:07 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id F2D9C240049;
        Tue,  1 Aug 2023 13:16:06 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 6900E240040;
        Tue,  1 Aug 2023 13:16:06 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 132B9312D9;
        Tue,  1 Aug 2023 13:16:05 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Aug 2023 13:16:04 +0200
From:   Martin Schiller <ms@dev.tdt.de>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Xie He <xie.he.0141@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Hendry <andrew.hendry@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH net-next RFC] MAINTAINERS: Add Martin Schiller as a
 maintainer for the X.25 stack
Organization: TDT AG
In-Reply-To: <20230801110902.ae24p3nltsudndw5@localhost>
References: <20201111213608.27846-1-xie.he.0141@gmail.com>
 <7baa879ed48465e7af27d4cbbe41c3e6@dev.tdt.de>
 <CGME20230801110904eucas1p2c09238963a8ff7726a50a68dc803d0c6@eucas1p2.samsung.com>
 <20230801110902.ae24p3nltsudndw5@localhost>
Message-ID: <1a468a8132d38bf2c5429e33e0f67b79@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate: clean
X-purgate-ID: 151534::1690888568-E11F2653-17979213/0/0
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-01 13:09, Joel Granados wrote:
> Hey everyone
> 
> I recently sent a patch and got a DNS error lookup for dev.tdt.de. Is
> Martins mail still valid? Should it be updated?

Hi Joel!

Yes, I'm still alive and reachable. ;-)

We had some technical issues with our DNS entry for the dev.tdt.de
subdomain after adding an spf entry, which is fixed now.

Regards,
Martin

> 
> Best
> 
> On Thu, Nov 12, 2020 at 08:06:37AM +0100, Martin Schiller wrote:
>> On 2020-11-11 22:36, Xie He wrote:
>> > Hi Martin Schiller, would you like to be a maintainer for the X.25
>> > stack?
>> >
>> > As we know the linux-x25 mail list has stopped working for a long time.
>> > Adding you as a maintainer may make you be Cc'd for new patches so that
>> > you can review them.
>> 
>> About 1 year ago I was asked by Arnd Bergmann if I would like to 
>> become
>> the maintainer for the X.25 stack:
>> 
>> https://patchwork.ozlabs.org/project/netdev/patch/20191209151256.2497534-4-arnd@arndb.de/#2320767
>> 
>> Yes, I would agree to be listed as a maintainer.
>> 
>> But I still think it is important that we either repair or delete the
>> linux-x25 mailing list. The current state that the messages are going
>> into nirvana is very unpleasant.
>> 
>> >
>> > The original maintainer of X.25 network layer (Andrew Hendry) has
>> > stopped
>> > sending emails to the netdev mail list since 2013. So there is
>> > practically
>> > no maintainer for X.25 code currently.
>> >
>> > Cc: Martin Schiller <ms@dev.tdt.de>
>> > Cc: Andrew Hendry <andrew.hendry@gmail.com>
>> > Signed-off-by: Xie He <xie.he.0141@gmail.com>
>> > ---
>> >  MAINTAINERS | 20 ++++++++++----------
>> >  1 file changed, 10 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 2a0fde12b650..9ebcb0708d5d 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -9832,13 +9832,6 @@ S:	Maintained
>> >  F:	arch/mips/lantiq
>> >  F:	drivers/soc/lantiq
>> >
>> > -LAPB module
>> > -L:	linux-x25@vger.kernel.org
>> > -S:	Orphan
>> > -F:	Documentation/networking/lapb-module.rst
>> > -F:	include/*/lapb.h
>> > -F:	net/lapb/
>> > -
>> >  LASI 53c700 driver for PARISC
>> >  M:	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>> >  L:	linux-scsi@vger.kernel.org
>> > @@ -18979,12 +18972,19 @@ L:	linux-kernel@vger.kernel.org
>> >  S:	Maintained
>> >  N:	axp[128]
>> >
>> > -X.25 NETWORK LAYER
>> > -M:	Andrew Hendry <andrew.hendry@gmail.com>
>> > +X.25 STACK
>> > +M:	Martin Schiller <ms@dev.tdt.de>
>> >  L:	linux-x25@vger.kernel.org
>> > -S:	Odd Fixes
>> > +L:	netdev@vger.kernel.org
>> > +S:	Maintained
>> > +F:	Documentation/networking/lapb-module.txt
>> >  F:	Documentation/networking/x25*
>> > +F:	drivers/net/wan/hdlc_x25.c
>> > +F:	drivers/net/wan/lapbether.c
>> > +F:	include/*/lapb.h
>> >  F:	include/net/x25*
>> > +F:	include/uapi/linux/x25.h
>> > +F:	net/lapb/
>> >  F:	net/x25/
>> >
>> >  X86 ARCHITECTURE (32-BIT AND 64-BIT)
