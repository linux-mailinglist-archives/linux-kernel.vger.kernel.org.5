Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E8A76586C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjG0QTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjG0QTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:19:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9B519B;
        Thu, 27 Jul 2023 09:19:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E883861EBD;
        Thu, 27 Jul 2023 16:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480EAC433C7;
        Thu, 27 Jul 2023 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690474741;
        bh=cJ2cDKD5pRIvYteZ8B5krBjQ4B4gVvlooKDjuLtiIhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eoEWnIFD83r351XEsxp9P0RXdeJV9VdRPJaqQPVxSVr+jN5IyccVQ+/S7XbnWF1Xd
         Fi+dY6eaQa23fbjGqg2iiL5vy4lk5My42x+IeOBgu6/Vz6lhzioUngM6bqQFiGNu0u
         wgRlTKneUqioguLi9gLciGvCkezMfKq77xSpfiEVbeBMvcEdXBnuz0eBMOKi9D4ZTo
         KqUZn6yavNDS4R4qWv8utnfN/dvR3VaY2wxM2oAx98sOa1SVtQn0Wv55LyLTdWCfej
         P7s8JBf02WimlJBXF6drFLzt7hynejm9FD0sQgC5VonCyvwRzgAuIXXGEA3y4z85Dc
         pYP+KCwIP6b6g==
Date:   Fri, 28 Jul 2023 00:07:23 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Kwanghoon Son <k.son@samsung.com>
Cc:     'Drew Fustini' <dfustini@baylibre.com>,
        'Conor Dooley' <conor@kernel.org>,
        'Guo Ren' <guoren@kernel.org>, 'Fu Wei' <wefu@redhat.com>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Krzysztof Kozlowski' <krzysztof.kozlowski+dt@linaro.org>,
        'Conor Dooley' <conor+dt@kernel.org>,
        'Paul Walmsley' <paul.walmsley@sifive.com>,
        'Palmer Dabbelt' <palmer@dabbelt.com>,
        'Albert Ou' <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        'Robert Nelson' <robertcnelson@beagleboard.org>,
        'Jason Kridner' <jkridner@beagleboard.org>
Subject: Re: [PATCH 1/3] riscv: dts: thead: add BeagleV Ahead board device
 tree
Message-ID: <ZMKWO2vksQn8dUR4@xhacker>
References: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
 <20230722-upstream-beaglev-ahead-dts-v1-1-ccda511357f4@baylibre.com>
 <20230723-savor-trolling-e35ed4a7a751@spud>
 <ZL1jlacHj7sgNg8M@x1>
 <CGME20230724003542epcas1p4c6c8dbd042af792bc168e10c6e81e45d@epcas1p4.samsung.com>
 <ZL3Eenj4lGZDhZTM@xhacker>
 <000001d9c070$82638290$872a87b0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000001d9c070$82638290$872a87b0$@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 06:55:37PM +0900, Kwanghoon Son wrote:
> > On Sun, Jul 23, 2023 at 10:29:57AM -0700, Drew Fustini wrote:
> > > On Sun, Jul 23, 2023 at 11:32:17AM +0100, Conor Dooley wrote:
> > > > On Sat, Jul 22, 2023 at 02:55:39PM -0700, Drew Fustini wrote:
> > > >
> > > > > +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > > > @@ -0,0 +1,61 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > >
> > > > Hmm, should this not be dual licensed?
> > > > I notice the other th1520 stuff isn't either..
> > >
> > > Good point, I'll resubmit with a dual license.
> > >
> > > Jisheng: are you okay with the other arch/riscv/boot/dts/thead files
> > > changing to a dual license?
> > 
> > When cooking the initial patch, I wrote the lpi4a dts files from
> > scratch based on sipeed opened sch file, and currently only I made
> > contributions to them, so it's easy to make the lpi4a dts files
> > dual license.
> 
> Thanks for your work.
> Is there any datasheet or user manual can get on public?

Sorry I can't help on datasheet.

> I'm going to contribute drivers in my spare time,
> but it's hard to know the register file and dma information.
>  
