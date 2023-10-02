Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6E47B4B81
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbjJBGeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbjJBGeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:34:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B866B4;
        Sun,  1 Oct 2023 23:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=7A/KMDKBE8KKFjARHLmB1nIOHjYb8NvPXa3L893Zobo=; b=Vd6id3aYngWV8sLNJ0M1uORius
        XH7PnLj9MQZXc233lu1sShLHiyZAZiDuNKb6pnJi58zhnP5wzrQau5NAMmXlpaakXMs9K0Cc9zmnq
        0nQR23uYB+Aiz0C3WBMoGVjXNEVJbfiUNCw6a0Vr2Sir43w2SM1DrdK4j1uajUHtvcc/wEd6547PY
        A2gHxrdDqubpLVqhkEACioGGomDd/n4ikk/CBixmbhnXnFKavZylOgPwI03Inxwa3/JEvcaNVQttt
        86ScApe1CtZXHNZcxpM33YAI9jMNmZVcEoV+p0DTRSwVX7zf/uTfZtkkxq80rNEJ+/XWRUN7gFwEq
        xdORP+iw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qnCVF-00C26J-27;
        Mon, 02 Oct 2023 06:34:01 +0000
Date:   Sun, 1 Oct 2023 23:34:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: submitting-patches: encourage direct notifications
 to reviewers
Message-ID: <ZRpkWXMiQjUJPszZ@infradead.org>
References: <20230927-docs-cc-reviewer-v1-1-2af46ceb2d3c@weissschuh.net>
 <ZRVDv2fiFyW2S0z1@infradead.org>
 <f4ce8205-93a6-4ef5-94c0-1fb8d261bcac@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4ce8205-93a6-4ef5-94c0-1fb8d261bcac@t-8ch.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 09:24:57AM +0200, Thomas Weißschuh wrote:
> > This does not scale.
> 
> Could you elaborate in which way it doesn't scale?

If I send a modest cross-subsystem series it often touches 20+
subsystems.  Between mailing lists and maintainers that's usually
already 60+ recipients.  If you now add a another 2-3 maintainers
we're just going to hit limits in mail servers.

> > Please read the mailinglist, that's the whole
> > point of having it.
> 
> When reviewing things in various subsystem this would require reading
> all of LKML, which is impractical.

Works with your maintainers to have useful lists for their subsystems.
That's again the point.
