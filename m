Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006947CE225
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbjJRQGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjJRQGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:06:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8B913E;
        Wed, 18 Oct 2023 09:06:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38939C433C7;
        Wed, 18 Oct 2023 16:06:05 +0000 (UTC)
Date:   Wed, 18 Oct 2023 12:07:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the ftrace tree with the
 kselftest-fixes tree
Message-ID: <20231018120744.1f17950c@gandalf.local.home>
In-Reply-To: <8482e2c8-9ee9-4207-9ad5-b2e66dd38b4a@linuxfoundation.org>
References: <20231018123014.65073211@canb.auug.org.au>
        <8482e2c8-9ee9-4207-9ad5-b2e66dd38b4a@linuxfoundation.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 10:01:04 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >   
> 
> Thank you Stephen.
> 
> Steve, how would you like to handle this one. I am planning
> to send fix to Linus this week to be included in Linux 6.6
> in a fixes update.

Feel free to send it as you expected to. I do a merge of Linus's tree before
sending a pull request for the merge window, and report all conflicts that
occur.

Linus is good at merge conflict resolution, so this should not be a problem.

-- Steve
