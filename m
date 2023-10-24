Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0447D57EE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjJXQUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjJXQUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:20:49 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7A9D10C2;
        Tue, 24 Oct 2023 09:20:40 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 39OGK3Ti004223;
        Tue, 24 Oct 2023 18:20:03 +0200
Date:   Tue, 24 Oct 2023 18:20:03 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        security@kernel.org, workflows@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Solar Designer <solar@openwall.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH] Documentation: security-bugs.rst: linux-distros relaxed
 their rules
Message-ID: <ZTfus7qKp2R5azJG@1wt.eu>
References: <20231015130959.26242-1-w@1wt.eu>
 <87zg0ajcha.fsf@meer.lwn.net>
 <2023102402-unheated-basis-55e5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102402-unheated-basis-55e5@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 11:24:27AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Oct 22, 2023 at 08:31:45PM -0600, Jonathan Corbet wrote:
> > Willy Tarreau <w@1wt.eu> writes:
> > 
> > > The linux-distros list relaxed their rules to try to adapt better to
> > > how the Linux kernel works. Let's update the Coordination part to
> > > explain why and when to contact them or not to and how to avoid trouble
> > > in the future.
> > >
> > > Link: https://www.openwall.com/lists/oss-security/2023/09/08/4
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Solar Designer <solar@openwall.com>
> > > Cc: Vegard Nossum <vegard.nossum@oracle.com>
> > > Acked-by: Jiri Kosina <jkosina@suse.cz>
> > > Signed-off-by: Willy Tarreau <w@1wt.eu>
> > > ---
> > >
> > > This is the final version for merging. Changes since RFC:
> > >   - s/BEFORE/UNTIL from Vegard
> > >   - improved wording from Alexander
> > >   - acked-by from Jiri
> > 
> > Greg, you've taken changes to this file in the past; do you want to grab
> > this one or should I pick it up?
> 
> I was hoping there would be other reviewers of it, but I guess not.

I'm pretty sure non-technical stuff like this actually bores everyone,
starting from us; when I proposed you to work on it, I was already
convinced that nobody would have stolen me that task!

> I'll take it through my tree now, thanks!

Thank you!
Willy
