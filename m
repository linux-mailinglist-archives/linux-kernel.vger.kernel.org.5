Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215217542C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjGNSs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbjGNSs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:48:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9802830E2;
        Fri, 14 Jul 2023 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=wwWk1HliTqQQPO8v2hVtZS53nVh7lT+9OasqHTS++Iw=; b=0Ki9w+I6egWHM4BkTjI79bwDhO
        CDvot7oR/irL+Wu5/xDyhqN1WQT38XUWi7iZRMFYM9HgqubuJKfTZ3B7tDsIDBfiLRXb5cggKT2gP
        VZG/9P/mfhCUCmxbb0Cax8bD2Bl70dy0La0B35zOnp8R2XnUoYOjSn8wB7YhLfmrWubI1d3Rpf7UY
        AQsOO9D4UiU0zMP5WQokwalZH2wnsf0z39KoLhppUg2I/kgSsgGKKNKP3QgPVz17iDQ0LFJ/euCtE
        eCYhRXe87kmVFXTpJyKr0CQBjZTK7CArZtSHJwux+bTUu3f2JryMGnA93ye2UWbS7VfK9fKXtn9wT
        wyklXkaw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qKNqV-00716f-2J;
        Fri, 14 Jul 2023 18:48:51 +0000
Date:   Fri, 14 Jul 2023 11:48:51 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the sysctl tree
Message-ID: <ZLGYkyRnu5+ZSEKo@bombadil.infradead.org>
References: <20230714144820.6724ce15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230714144820.6724ce15@canb.auug.org.au>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 02:48:20PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> The following commit is also in Linus Torvalds' tree as a different
> commit (but the same patch):
>=20
>   5664eaac4dcf ("sysctl: fix unused proc_cap_handler() function warning")
>=20
> This is commit
>=20
>   554588e8e932 ("sysctl: fix unused proc_cap_handler() function warning")
>=20
> in Linus' tree.


Thanks, fixed, although now my tree has nothing pending.

  Luis
