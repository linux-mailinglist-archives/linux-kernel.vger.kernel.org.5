Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086DF781A5D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 17:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjHSPfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 11:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjHSPfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 11:35:33 -0400
X-Greylist: delayed 447 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Aug 2023 08:35:30 PDT
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0C5859F8;
        Sat, 19 Aug 2023 08:35:30 -0700 (PDT)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id D4FAB40A03; Sat, 19 Aug 2023 17:25:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org D4FAB40A03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1692458733;
        bh=j/MBHbRcsMX9PPuXauIuuKH6HsPvMiHxskwoP/V5mL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vP28gEdEyroY+t2UH9M8WP97VPa7azhYgguo/Rt0xUJ/B3cjmtF6ApCPOfzN8edhX
         M/jPTx9xzkPoOX5mKtW4zOU47c79exwzlq1WfUEPVq8DCEY1Q03DPyICXIzGK7tKTx
         gL49FCCWcWCwgBBL7jQMY/amDaUn9YnSyeie2d+w=
Date:   Sat, 19 Aug 2023 17:25:33 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <markgross@kernel.org>,
        Henning Schild <henning.schild@siemens.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the drivers-x86 tree
Message-ID: <20230819152533.GA18546@www.linux-watchdog.org>
References: <20230815165725.30a01fe9@canb.auug.org.au>
 <20230815165856.051fb20f@canb.auug.org.au>
 <2f9489b4-2414-9f03-4f66-9838b8ee6be0@redhat.com>
 <e4eb2acd-7ed4-43f2-af9d-116cec77fc31@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4eb2acd-7ed4-43f2-af9d-116cec77fc31@roeck-us.net>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> On Tue, Aug 15, 2023 at 09:59:45AM +0200, Hans de Goede wrote:
> > Hi,
> > 
> > On 8/15/23 08:58, Stephen Rothwell wrote:
> > > Hi Stephen,
> > > 
> > > On Tue, 15 Aug 2023 16:57:25 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >>
> > >> Hi all,
> > >>
> > >> The following commit is also in the watchdog tree as a different commit
> > >> (but the same patch):
> > >>
> > >>   3fce06406c59 ("watchdog: make Siemens Simatic watchdog driver default on platform")
> > >>
> > >> This is commit
> > >>
> > >>   926df9ae133d ("watchdog: make Siemens Simatic watchdog driver default on platform")
> > > 
> > > in the watchdog tree.
> > 
> > Guenter, IIRC we agreed that I would merge this one through
> > the pdx86 tree?
> > 
> I thought that applied to the rest of the series. I tagged this patch
> with Reviewed-by: which generally means for Wim to pick it up. Ultimately
> I don't really care either way. I'll drop the patch from my tree.
> Note though that this doesn't mean that Wim will pick up the drop.

Also dropped in the linux-atchdog-next tree.

Kind regards,
Wim.

