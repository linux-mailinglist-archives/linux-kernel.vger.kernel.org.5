Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8117E04BF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377884AbjKCObJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377886AbjKCObG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:31:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96225D50
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O7TowLCVVl75YZ3vu1YYsx8+87Z9jus6OxwqSEwsnAY=; b=bCoPCIH9FbUGW2zngfXMaaRMVU
        PkvXlgM+eG764fqaq6m8182tP+fsiTZUzDrEwRYUEKESHRaxiOsLCCYRsCu3Q0ZB1a/zfNcW1hmSM
        4T5MICsk/KGgtGSX8GYK4PcmZlRCaGBa+HtQvTB8VGmR83P850iQi2WyX891UrbaQiwhXB1S8h7wr
        Cw1jxeGyqpsxO15Q4hTzpJbRfNfyXo0Je1YHSWuAYeLFduWyk3j6khZY0WolSJb5s61brhpckvx8C
        DSKB/UVTzGeNcLXEtuoPNCOpDbduoOLz4DhaZal5eGYfIjiCWzF9rAoPdgmjlnKUPO2BRfxpe6/ki
        01+OZGLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qyvCK-00BaDO-1a;
        Fri, 03 Nov 2023 14:30:56 +0000
Date:   Fri, 3 Nov 2023 07:30:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@ger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Vernet <void@manifault.com>,
        Miguel Ojeda <ojeda@kernel.org>, James Seo <james@equiv.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH RFC 0/4] Documentation: Web fonts for kernel documentation
Message-ID: <ZUUEIBx1txD8YQgU@infradead.org>
References: <20231102120053.30630-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102120053.30630-1-bagasdotme@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 07:00:42PM +0700, Bagas Sanjaya wrote:
> Intro
> =====
> 
> The Linux kernel documentation is primarily composed of text (both
> prose and code snippets) and a few images. Hence, making the text
> easy to read by proper typography choices is crucial.

No, it's not.  Not to the point where we need to ship a font with the
kernel tree for sure.

