Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED28805165
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345022AbjLELAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjLELAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:00:30 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4C6F116;
        Tue,  5 Dec 2023 03:00:32 -0800 (PST)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1rATAC-0000XE-00; Tue, 05 Dec 2023 12:00:28 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 26F26C0A1E; Tue,  5 Dec 2023 12:00:15 +0100 (CET)
Date:   Tue, 5 Dec 2023 12:00:15 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-mips@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@rothwell.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/20] mips: address -Wmissing-prototypes warnings
Message-ID: <ZW8Cv8ck9JoyLuLi@alpha.franken.de>
References: <20231204115710.2247097-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204115710.2247097-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 12:56:50PM +0100, Arnd Bergmann wrote:
> The patches could either go through Thomas's mips tree, or
> alternatively through linux-mm along with the hexagon patches
> that Andrew has already merged.

I'd prefer to have in MIPS tree to also fix the other missing pieces.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
