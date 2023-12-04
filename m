Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331528035AD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjLDN5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDN5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:57:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9014390
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:57:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C03C433C8;
        Mon,  4 Dec 2023 13:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701698236;
        bh=P61qJT7k6TtCOcd2ljpk3rt4h0DdkrkYLDxklJ+6th4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kFy3SNdFk/IecCWU/k9jrIllvNd4aYD8qAEhXYvdFJJ4lXo1METiaJvuddcv96/zB
         ZIHdJxRQSXQpnJzB4JuANAyxZIXNN05m+FlUJva4Y2FqTXq07Wu0SLYqi+Cq7UWd9p
         /xutoEFpB7pORUXVaFLJaq30WM+4xG7c/fqk1o98f2d96ZGNbUgGMW9aDseiPCnx9U
         jRYbPPvch+KEkFnbH0kAb4ukvE8EjQR2fzYF3XwUr9teB6TIA+rXb6r0zxOdJSuP8T
         DMjqk9enOL+klccrAWdXtjO6A+Xul2Mb0tiQ23Oepcgg5zWYWpRMKC+YNuQvGQhx6X
         m2p7SxIgeUQUQ==
From:   Maxime Ripard <mripard@kernel.org>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Frank Binns <frank.binns@imgtec.com>
Cc:     donald.robson@imgtec.com, matt.coster@imgtec.com
In-Reply-To: <20231204132847.1307340-1-frank.binns@imgtec.com>
References: <20231204132847.1307340-1-frank.binns@imgtec.com>
Subject: Re: (subset) [PATCH] MAINTAINERS: Document Imagination PowerVR
 driver patches go via drm-misc
Message-Id: <170169823361.9852.12738363315803901923.b4-ty@kernel.org>
Date:   Mon, 04 Dec 2023 14:57:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2023 13:28:47 +0000, Frank Binns wrote:
> This is the tree used by nearly all other DRM drivers, so use it for the
> PowerVR driver as well.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

