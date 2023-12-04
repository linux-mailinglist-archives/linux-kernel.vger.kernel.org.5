Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199BA802DF7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbjLDIoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbjLDIoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:44:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B96198B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:43:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAA6C433C8;
        Mon,  4 Dec 2023 08:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701679430;
        bh=lDOXjN/W84Vq3sykgf0bUUGkHQwP88whG8TRkS7Nx44=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WVLjR8vdJwdvEjNXZSMe8Lp1vcM5owgcUib2prYQjTy0EgDp0Om8FIjXQcQ1rbcbQ
         fQLWWvEOllo3g9AmgI7Gjg7cOagUiRiV7SnKfzGFuNkCuA0rbBz65oBUfqTwreubxD
         QVQdwh2v5ZRtFRbx9CDxwJN5LNyFBjlU3ciSzYovIt2RuI0hdP0x5KETnIWYCmskBK
         kKCcVdf6QvWPD3uE8T4h9PdVMciyQjO9UtIlvW6JloR7eQN7kFuAWmV79kmcBkWDKm
         5JpF+Qki6Casz1xtMtz5hQ2LSrHqd87jUHqVH8/B2v5Y+VcZgjM+VrCJ9OQeStZJSv
         CF1MrnJ1MrbRA==
From:   Maxime Ripard <mripard@kernel.org>
To:     airlied@redhat.com, kraxel@redhat.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        heminhong <heminhong@kylinos.cn>
Cc:     virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231110055031.57360-1-heminhong@kylinos.cn>
References: <20231110055031.57360-1-heminhong@kylinos.cn>
Subject: Re: [PATCH] drm/qxl: remove unused declaration
Message-Id: <170167942791.3617818.9387915211880062681.b4-ty@kernel.org>
Date:   Mon, 04 Dec 2023 09:43:47 +0100
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

On Fri, 10 Nov 2023 13:50:31 +0800, heminhong wrote:
> Some functions are never used by the driver,
> removing the functions declaration, it can be reducing program size,
> and improving code readability and maintainability.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

