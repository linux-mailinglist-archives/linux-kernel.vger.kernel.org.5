Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7437CBC56
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjJQHfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjJQHfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:35:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F94595
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:35:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED4EC433C7;
        Tue, 17 Oct 2023 07:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697528103;
        bh=uFcJLd6HAdVliYI8o7pEF7cyGfZ+4ll1EYpzGw8A6s8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AV0UvdJHc8R/P8WUH8SZztzDgI6WSYhJUxuEjlWRV+benN2o6GGhuy5GXDDMQ8S/p
         eMYbfX01rSTa3CM2utRcaoJw2uu9Ldnx0WueGLQm/S/gsb42IOvf2lC1xYzMO4Dm9L
         UfudN0EhAWzVhxpFq9/xqjLXKFUhXe6RQO7L6l/0=
Date:   Tue, 17 Oct 2023 09:17:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     gustavo@embeddedor.com, outreachy@lists.linux.dev,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Deepak R Varma <drv@mailo.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: coding style corrections
Message-ID: <2023101723-molar-defective-7193@gregkh>
References: <ZS4ysMWnjvWmnPvI@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS4ysMWnjvWmnPvI@lab-ubuntu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 10:07:28AM +0300, Calvince Otieno wrote:
> This patch brings the codebase in compliance with the Linux kernel coding
> style guidelines, as outlined in the document at
> https://www.kernel.org/doc/html/latest/process/coding-style.html.
> 
> Changes Made:
> - Adjusted line lengths to a maximum of 80 characters
> 
> The guide states that the preferred limit on the length of a single
> line is 80 columns. Statements longer than 80 columns should be broken
> into sensible chunks, unless exceeding 80 columns significantly increases
> readability and does not hide information.

100 columns is ok to use now, so this patch should not be needed.

sorry,

greg k-h
