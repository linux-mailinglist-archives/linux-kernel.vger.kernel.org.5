Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BAE762948
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjGZDa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGZDaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:30:25 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79E2B213C;
        Tue, 25 Jul 2023 20:30:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E4C9280A9;
        Wed, 26 Jul 2023 03:30:23 +0000 (UTC)
Date:   Wed, 26 Jul 2023 06:30:22 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update TTY layer for lists and recently
 added files
Message-ID: <20230726033022.GA5194@atomide.com>
References: <20230721072334.59272-1-tony@atomide.com>
 <ZLpboaXKVOOjeGJ+@smile.fi.intel.com>
 <20230724045327.GV5194@atomide.com>
 <2023072517-onward-payment-569d@gregkh>
 <2023072530-wired-chaps-c1e3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023072530-wired-chaps-c1e3@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230725 17:30]:
> On Tue, Jul 25, 2023 at 07:28:46PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jul 24, 2023 at 07:53:27AM +0300, Tony Lindgren wrote:
> > > * Andy Shevchenko <andriy.shevchenko@intel.com> [230721 10:19]:
> > > > On Fri, Jul 21, 2023 at 10:23:32AM +0300, Tony Lindgren wrote:
> > > > > Add mailing lists for linux-serial and lkml for the TTY layer. And let's
> > > > > list the recently added files. This makes it easier for get_maintainer.pl
> > > > > to include linux-serial for patches.
> > > > 
> > > > Shouldn't serial_* stuff go to the "SERIAL DRIVERS" section?
> > > 
> > > Not sure if there's some reason we have "TTY LAYER" with serial_core
> > > files. If not, yeah let's move the serial files.
> > 
> > I'll take this patch, can you send a new one that removes the serial
> > files from this entry as I don't think they are needed in here anymore.
> 
> Better yet, they should be merged probably.  Although I don't know if
> Jiri wants to be responsible for serial stuff, that's his call...

If Jiri does not care about all the serial port device drivers, we could
have the following three entries:

TTY LAYER
SERIAL CORE LAYER
SERIAL DRIVERS

Regards,

Tony
