Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9687C7E62
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjJMHJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjJMHJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:09:15 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F0C6BD;
        Fri, 13 Oct 2023 00:09:10 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 39D78Pj8021427;
        Fri, 13 Oct 2023 09:08:25 +0200
Date:   Fri, 13 Oct 2023 09:08:25 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Solar Designer <solar@openwall.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, corbet@lwn.net, workflows@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH] Documentation: security-bugs.rst: linux-distros
 relaxed their rules
Message-ID: <ZSjs6aUM7ZSdwKQ5@1wt.eu>
References: <20231007140454.25419-1-w@1wt.eu>
 <5ae47535-b6e0-8b48-4d59-a167e37c7fcc@oracle.com>
 <20231007163936.GA26837@1wt.eu>
 <20231012215122.GA8245@openwall.com>
 <20231013034712.GC15920@1wt.eu>
 <nycvar.YFH.7.76.2310130853320.3534@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2310130853320.3534@cbobk.fhfr.pm>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 08:54:03AM +0200, Jiri Kosina wrote:
> On Fri, 13 Oct 2023, Willy Tarreau wrote:
> 
> > Jiri, does your Acked-by still stand with these adjustment ? If so, I'll
> > resend the updated version today or this week-end, as time permits.
> 
> As it doesn't change the spirit but pretty much just improves the wording, 
> my Ack still holds.

Perfect, thank you!
Willy
