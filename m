Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF39B7FBAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344873AbjK1NAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344975AbjK1NAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:00:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB1110F4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:00:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28271C433C8;
        Tue, 28 Nov 2023 13:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701176452;
        bh=iQY4bJQiN3c6pMqgOKt7BcxpAUaqyamtlGBhvbZfDco=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=F7j6DxAAvfbSz1ShjmsAJbPvKAhHvGylm9giBbGWCDU/Xnbk/BH0+rlZmOfel/UQ7
         zHLA3nw1PmaOckhJnAiw5+q06b4TonZU76jkmts2JEQVCE+cboKi/F8cXnY5sH3Oe1
         znEWErND0IH7bv9nzn1Yg3EzdHPvFLH9KyXx2xEY3mZXZMUeEdZRuzAW3WzvGKdlUQ
         /HsMVUW3BIKIFDWCuiP7UGPN0tIZJlzH045j1VhpK6BZfJBp4D5WxfbSrsvXAgaD6L
         nR46WYDOTy0pVx4oZpVdduR4XsIcxnobfKabOLwTPpdDCp4qQu1B/gh+xAsNmE0bgG
         T4vW7ldjP7rjQ==
From:   Maxime Ripard <mripard@kernel.org>
To:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231124163917.300685-1-colin.i.king@gmail.com>
References: <20231124163917.300685-1-colin.i.king@gmail.com>
Subject: Re: (subset) [PATCH][next] drm/imagination: Fix a couple of
 spelling mistakes in literal strings
Message-Id: <170117645007.2825698.11061509087464086760.b4-ty@kernel.org>
Date:   Tue, 28 Nov 2023 14:00:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 16:39:17 +0000, Colin Ian King wrote:
> There are a couple of spelling mistakes in literal strings in the
> stid_fmts array. Fix these.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

