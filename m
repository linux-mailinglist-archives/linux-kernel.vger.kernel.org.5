Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692077CF345
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbjJSIwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjJSIw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:52:28 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4A3110F;
        Thu, 19 Oct 2023 01:52:22 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qtOlP-0004JL-00; Thu, 19 Oct 2023 10:52:19 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 3E125C0148; Thu, 19 Oct 2023 10:49:22 +0200 (CEST)
Date:   Thu, 19 Oct 2023 10:49:22 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] MIPS: AR7: remove platform
Message-ID: <ZTDtkjXcOkxVataJ@alpha.franken.de>
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
 <20230922061530.3121-7-wsa+renesas@sang-engineering.com>
 <ZRUl6+i/o0cqCV+6@ninjato>
 <ZRUrVgHyJvvhteGs@alpha.franken.de>
 <ZRUwEjpfILlF5dgE@ninjato>
 <ZR/DNeUMn+BD2NMD@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR/DNeUMn+BD2NMD@alpha.franken.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 10:20:05AM +0200, Thomas Bogendoerfer wrote:
> On Thu, Sep 28, 2023 at 09:49:38AM +0200, Wolfram Sang wrote:
> > 
> > > > most people involved in this series think that it will be best to take
> > > > the whole series via the MIPS tree. Do you agree?
> > > 
> > > I'm fine taking it.
> > 
> > Awesome, thank you!
> 
> the series doesn't apply to mips-next, can you rebase it top of it ?

nevermind, I've did it by hand, but using --irreversible-delete isn't very
maintainer friendly as patches won't apply and I need to do the git rm
manually.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
