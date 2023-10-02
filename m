Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035A47B4D98
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbjJBIuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbjJBIuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:50:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF592A4;
        Mon,  2 Oct 2023 01:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=JvPqqja4TT+0DiPiuayTezJPxFas7IWcUxfob75N93Q=; b=j8q+pCOmMl9PBJYEFd31OtM6/B
        Aia4gbdLMLjyJU+41olyFt7x30GOR9G++wJpc0o1y4BW6S2QYxRcw/yAI0+Ng5bHvmy7zqhjyDtpi
        U0b2gHhfZhLrSVI/HrjMDZm+2HiB5hDV7QswuB3yvKpTqD5p80UaRqeSwoibl5Q2KOFmmRnlTHOnQ
        Zu87S6VcpJUbFR5qo+XGMg2JUmO1agmbAvBEfCaRff/GGOFkLYK18jJhkJ0Vq/gJNW5vyqDOiP/s+
        CmMOb3nYRPAOu3cIvNHJUHpouLZ1BLvtvQz0vm9CJlJuObis5sT3lF6x/tfHycVdcv4oLnyi1qjAk
        MUvN5TSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qnEd1-00CA60-0m;
        Mon, 02 Oct 2023 08:50:11 +0000
Date:   Mon, 2 Oct 2023 01:50:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: submitting-patches: encourage direct notifications
 to reviewers
Message-ID: <ZRqEQ2uxAlCyihS3@infradead.org>
References: <20230927-docs-cc-reviewer-v1-1-2af46ceb2d3c@weissschuh.net>
 <ZRVDv2fiFyW2S0z1@infradead.org>
 <f4ce8205-93a6-4ef5-94c0-1fb8d261bcac@t-8ch.de>
 <ZRpkWXMiQjUJPszZ@infradead.org>
 <874jj9iihq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874jj9iihq.fsf@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 10:36:01AM +0300, Jani Nikula wrote:
> On Sun, 01 Oct 2023, Christoph Hellwig <hch@infradead.org> wrote:
> > On Fri, Sep 29, 2023 at 09:24:57AM +0200, Thomas Weißschuh wrote:
> >> > This does not scale.
> >> 
> >> Could you elaborate in which way it doesn't scale?
> >
> > If I send a modest cross-subsystem series it often touches 20+
> > subsystems.  Between mailing lists and maintainers that's usually
> > already 60+ recipients.  If you now add a another 2-3 maintainers
> > we're just going to hit limits in mail servers.
> 
> I thought this was about adding people who have commented on previous
> versions to Cc. That's usually a very limited number.

Oh, that absolutely makes sense.  But maybe we need to stop overloading
the term reviewer :)

