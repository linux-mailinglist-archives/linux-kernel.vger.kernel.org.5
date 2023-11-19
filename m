Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9F57F0511
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 10:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjKSJvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 04:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKSJvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 04:51:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE439F9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 01:51:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC946C433C8;
        Sun, 19 Nov 2023 09:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700387478;
        bh=cql7uwNHrLXhCwdTp6wuAmUzrMGqLGwGSZIfEH0L+ZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SPaPNm2N3PGxpFO1wxjOh038+Qobc+QbbKP0BZAswqu8CA4oAvPlZnxX9rFT6RLES
         yg1QSoJTnT2Cbu/94r5TZ8hE7RyUqFAkYHm03QJ43WcJpV06NTyv2DTGy+2CwWc/P9
         E3AQIidb05pgBnHNE0+Oj/C/jL284DZ1UvXdCA2U=
Date:   Sun, 19 Nov 2023 10:51:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V2 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023111956-strangle-pantyhose-0814@gregkh>
References: <20231119092450.164996-1-saeed@kernel.org>
 <20231119092450.164996-3-saeed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119092450.164996-3-saeed@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 01:24:47AM -0800, Saeed Mahameed wrote:
> igned-off-by: Saeed Mahameed <saeedm@nvidia.com>

Something went wrong here :(
