Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9BD7C7E32
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjJMGyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJMGyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:54:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F2091;
        Thu, 12 Oct 2023 23:54:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A115AC433C8;
        Fri, 13 Oct 2023 06:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697180047;
        bh=nr8fpppCCpes0TPI97zPmzyYSXvU36WGGZWf3aHc5C8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=h74FvzZAiV0rKj0VS6ofjX1kaIgCrHLEPDscvnkCRQLy/8S5T+JD5Utb1lGnCiEg5
         NEM+fPkuszfkUv4PGVOgA3c2tSqM85DcKMJJPF7Z9OF/mAGr1hoE7sjkh40rf9qSfJ
         AawIutr4yDaieO26Wn/jByJwjTKSct+DSWIoaO/SwxhbeQfCaxwvJtpnZbVDIT91Bb
         49tf2HuEYc0umHl87k4aqyYa3V4iWrrZaEtD/KDBMbJkQswxR7PZn2oyTrcXRsvjp4
         kNzAhG6CYcgB/+AvJEuUTKJ4y8Ol7wiuL2axQkOdWTrCrt58qJ8oMII+rKYbHNvxmK
         lU990PNR8E67A==
Date:   Fri, 13 Oct 2023 08:54:03 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
cc:     Solar Designer <solar@openwall.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, corbet@lwn.net, workflows@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH] Documentation: security-bugs.rst: linux-distros
 relaxed their rules
In-Reply-To: <20231013034712.GC15920@1wt.eu>
Message-ID: <nycvar.YFH.7.76.2310130853320.3534@cbobk.fhfr.pm>
References: <20231007140454.25419-1-w@1wt.eu> <5ae47535-b6e0-8b48-4d59-a167e37c7fcc@oracle.com> <20231007163936.GA26837@1wt.eu> <20231012215122.GA8245@openwall.com> <20231013034712.GC15920@1wt.eu>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023, Willy Tarreau wrote:

> Jiri, does your Acked-by still stand with these adjustment ? If so, I'll
> resend the updated version today or this week-end, as time permits.

As it doesn't change the spirit but pretty much just improves the wording, 
my Ack still holds.

Thanks again,

-- 
Jiri Kosina
SUSE Labs

