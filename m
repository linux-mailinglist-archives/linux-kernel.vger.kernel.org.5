Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEEB7802B3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 02:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356459AbjHRAWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 20:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbjHRAVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 20:21:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13BAE40;
        Thu, 17 Aug 2023 17:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PF8aIUtYPk2iIjEEUZ6yVH0U/xX0BgsekCmFCkc+QAE=; b=hP0XlMXww5BQ1maX6NT8sxlal9
        80ojI0CHZDJovGEgm0NVYp7mrn80EBnFMIt4WFsy45brX3S4EJBt5t2f0U8qKjgWbF5KJmJz0LGFn
        r05RzgYdWLpyZc18VFMe46O1E0q1ZYid9TPcEADqEY8iltnQBFWOI59kH96p9HiboL1zen6Kt61f0
        l3li8ds8seaKXVeLz43xgMwZRxZAy+pen1/6Ny7coocKVi1AARNoueWFxl3VRBsLvl8KdauyTe3/R
        vd7Jpyq5KIEiA/ylnBoeXAx68lb5tHdA0ifwr/HiHmHaPCLtBOlBn9ZpYjjyDBcE+VCQt3bHFmTNQ
        c4DY6iMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWnF4-006HpX-7D; Fri, 18 Aug 2023 00:21:30 +0000
Date:   Fri, 18 Aug 2023 01:21:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] docs: submitting-patches: Add Sponsored-by tag
 to give credits to who sponsored the patch
Message-ID: <ZN65iiRiSLmXz89k@casper.infradead.org>
References: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
 <20230817220957.41582-2-giulio.benetti@benettiengineering.com>
 <20230817232348.GC1175@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817232348.GC1175@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 02:23:48AM +0300, Laurent Pinchart wrote:
> Just adding one data point here, without judging on the merits of this
> proposal. I've been requested previously by customers to increase their
> visibility in the kernel development statistics, and the way we found to
> do so was to sign-off patches with
> 
> Laurent Pinchart <laurent.pinchart+customer@ideasonboard.com>
> 
> (where "customer" is to be replaced with the customer name).

I quite like Sponsored-by: but yet another approach could be the
same as that used by those of us whole use personal email addresses
while being employed by someone.  So my SoB is:

Matthew Wilcox (Oracle) <willy@infradead.org>

but you might have (eg)

Laurent Pinchard (Coca-Cola) <laurent.pinchart@ideasonboard.com>

and then when working for another sponsor:

Laurent Pinchard (Ford) <laurent.pinchart@ideasonboard.com>

