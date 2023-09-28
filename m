Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803EA7B16FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjI1JRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjI1JRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:17:07 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E800FB7;
        Thu, 28 Sep 2023 02:17:03 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-21-184-nat.elisa-mobile.fi [85.76.21.184])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4C14BD20;
        Thu, 28 Sep 2023 11:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695892517;
        bh=5OiHmM4SWJrhoZuRN9/s69x66RArTP5AfDIFSku2j4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gg0ZylctZtsWWmSO+AmFUVmCMLxaVw1Fxmg4TKb3QgatIiF3Jaz4iejGhLrWqAhdf
         OKiT8S7BpLcPWU5wpPh/mm9xpyznpHon60XZGipnoPEZQd521tPDS7fi5mC9Mv9mcp
         ZAsb8Ps1Ev+cuLDCK5o2otCQwVzqcNoH+kx7YXW8=
Date:   Thu, 28 Sep 2023 12:17:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: submitting-patches: encourage direct notifications
 to reviewers
Message-ID: <20230928091707.GB13399@pendragon.ideasonboard.com>
References: <20230927-docs-cc-reviewer-v1-1-2af46ceb2d3c@weissschuh.net>
 <ZRVDv2fiFyW2S0z1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRVDv2fiFyW2S0z1@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 02:13:35AM -0700, Christoph Hellwig wrote:
> NAK.
> 
> This does not scale.  Please read the mailinglist, that's the whole
> point of having it.

Can lei help here, would there be a way to match on new versions of a
series based on who was in the mail thread for previous versions ?

-- 
Regards,

Laurent Pinchart
