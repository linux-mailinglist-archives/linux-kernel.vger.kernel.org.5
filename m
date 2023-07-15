Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D262754CCB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 00:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGOWqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 18:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGOWqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 18:46:48 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32D792117;
        Sat, 15 Jul 2023 15:46:47 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 36FMjBLb031853;
        Sat, 15 Jul 2023 17:45:11 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 36FMj9gd031852;
        Sat, 15 Jul 2023 17:45:09 -0500
Date:   Sat, 15 Jul 2023 17:45:09 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Dr. Greg" <greg@enjellic.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] Update MAINTAINERS file.
Message-ID: <20230715224509.GA31842@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230710102319.19716-1-greg@enjellic.com> <20230710102319.19716-2-greg@enjellic.com> <fa1d9a4c-16fe-955d-071b-d39f1a0d9b58@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa1d9a4c-16fe-955d-071b-d39f1a0d9b58@infradead.org>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sat, 15 Jul 2023 17:45:11 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 01:00:58PM -0700, Randy Dunlap wrote:

> Hi,

Hi Randy, I hope your are having a good weekend.

> On 7/10/23 03:23, Dr. Greg wrote:
> > Add an entry to the MAINTAINERS file to document the maintainer's
> > address and files relevant to the Trusted Security Event Modeling
> > system (TSEM).
> > 
> > Signed-off-by: Greg Wettstein <greg@enjellic.com>
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 35e19594640d..4660c972d5e3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19026,6 +19026,14 @@ F:	include/uapi/linux/selinux_netlink.h
> >  F:	scripts/selinux/
> >  F:	security/selinux/
> >  
> > +TSEM SECURITY MODULE
> > +M:	Greg Wettstein <greg@enjellic.com>
> > +S:	Maintained
> > +L:	linux-security-module@vger.kernel.org
> > +F:	Documentation/admin-guide/LSM/tsem.rst
> > +F:	Documentation/ABI/testing/tsemfs
> > +F:	security/tsem/
> > +

> Please insert entries in the MAINTAINERS file in alphabetical order
> (as stated in that file).

Fixed, my apologies for missing the note in the MAINTAINERS file.

> Thanks.
> -- 
> ~Randy

Have a good remainder of the weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
