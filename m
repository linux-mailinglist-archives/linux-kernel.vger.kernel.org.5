Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1545776B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjHIWAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjHIWAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:00:31 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A453A1FF5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:00:30 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CDF0540E01A2;
        Wed,  9 Aug 2023 22:00:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uo6nc3bd2F6i; Wed,  9 Aug 2023 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691618426; bh=PnZ+V9UhMu3zPlLC4O62QNGQqJO52LpO78DLER8qgbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wif3TpIbukB7TEey7sqcv4rbcHnv1I4vnPUVN01jbPB41REVoghd0mgwR2XpmzQHR
         wFNHSgmCxuW/Zpua1v/v1nPFlNiKJQA9lzJg6PGhKwej9A3KpYVM0xLWMGTcy3uX9C
         yoiwNfWzvwuLrZ5e+a4iS8aLboluPT6HyXNrLiySn7c2nKeLBE6Ww1j6yNKBwbRaE9
         CFWjX8ul5O1bCt5L+BYa4zjz0l3juaXPCN5HkZ/Gm6zOYgbBzk/sTWAQkAsjLDq72B
         9KKfrIyB53RtRzauZXV+/XsK9HH5j4HEdF3zA37+d8jQCc4JYAPqMgTvG4eGn6xwnI
         uUsW7r6EfPsgW+XewFNLWjL5e8d0SVfCs+bbjPp7QWwpVGiaMp7HGjzmOX+39rVqUD
         APLvWkZjdJO5YyhUl7oXY6Vu2ykuPbwe5I47u+XFckzJa7teKkkhEBW6fhMxc8yXlh
         F9EOnpt6KfcROJcUGA7otSbb2KoSXWFotP7IsdtY3jzeH++q0VcOnL9KVChoTN9gqA
         KnCFA56KmcwDnETOml4/vcfRfrjqDJMe5lmEZHbDWOn/AdF9bhqVTbIuEzhqtoXlkO
         qVHsYLPor3VlzpDlsiH2Udg15Qudm0wglyEKXHQP+UnOimQRiwcKGM5nOlBcdA877b
         7uGwGOXD/hjygtuD5x3huJNY=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9832740E01A0;
        Wed,  9 Aug 2023 22:00:21 +0000 (UTC)
Date:   Thu, 10 Aug 2023 00:00:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     X86 ML <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] Documentation/hw-vuln: Unify filename specification
 in index
Message-ID: <20230809220015.GQZNQMbyboYOKVMh3H@fat_crate.local>
References: <20230809102700.29449-1-bp@alien8.de>
 <20230809102700.29449-2-bp@alien8.de>
 <20230809213214.ns7t2enjrgnms2ee@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809213214.ns7t2enjrgnms2ee@desk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 02:32:14PM -0700, Pawan Gupta wrote:
> While at it could you please also change this?

Yes, I can.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
