Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3333676B89F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjHAPbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjHAPbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:31:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89771FEE;
        Tue,  1 Aug 2023 08:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEA07615F9;
        Tue,  1 Aug 2023 15:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344A7C433C8;
        Tue,  1 Aug 2023 15:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690903906;
        bh=O1j0cFtt/OwyMMnLCbpMAX6DujFxHllzjlfgEiYVYH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D/egdKDtQKBLiyGMYKlUqsmkWZULs3obHJLWRdC6SeNb++6jUZA1LkKNCD6e5Q57o
         rNPb8oHdJaUzTLyeq1lSk6wF5efdR86uENZKbld1TuJsmkTSiOSFcnoZbejTIGyRZx
         t5gVu3qrKUqiCXX37d1ctfFBZPDWEmwCUbjAlBoK+fWOdcKHfUbb+/yWOiIo7YZDBi
         OxUrh7/l6B35JY9ycOKQmg6h1ND13YqGHpsFqPi5IzUDyfiud1Q7pGwf4yltGpiWwc
         k6AcLFg3cQ0UuxE1Qe3GM/Ac9CZQRLjhMyZvorj1o5ZvMBb8IHKURQw4dnI2sT67QI
         vCYAlFaop5mNw==
Date:   Tue, 1 Aug 2023 08:31:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     pangzizhen001@208suo.com
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/xfs: Fix typos in comments
Message-ID: <20230801153145.GH11377@frogsfrogsfrogs>
References: <20230720154942.56848-1-wangjianli@cdjrlc.com>
 <d8927acfb0f11e0bcd2d7a015a0238a7@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8927acfb0f11e0bcd2d7a015a0238a7@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 11:51:06PM +0800, pangzizhen001@208suo.com wrote:
> Delete duplicate word "the"
> 
> Signed-off-by: Zizhen Pang <pangzizhen001@208suo.com>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_aops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 451942fb38ec..66b311ccc4f9 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -478,7 +478,7 @@ xfs_discard_folio(
>              folio, ip->i_ino, pos);
> 
>      /*
> -     * The end of the punch range is always the offset of the the first
> +     * The end of the punch range is always the offset of the first
>       * byte of the next folio. Hence the end offset is only dependent on
> the
>       * folio itself and not the start offset that is passed in.
>       */
