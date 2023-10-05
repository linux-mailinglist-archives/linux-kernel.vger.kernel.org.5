Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CD27BA752
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjJERIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjJERH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:07:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D3F1B2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:52:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD05CC433C7;
        Thu,  5 Oct 2023 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696524764;
        bh=MgFWaWNx9i/xDOOSQ9MpMUgMmqSc1reTXGh7sUetAUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNfm48lPKFk4SywQqYaqYcII1gJDK81NxrWN29C2L9Z1vr4lu5Uzzl1pWCSJI+VOB
         VPH4ztGOHA9Gt4nfo0k0xg9ejrC+pPq/4QQjXQZ4mYT90S8XBxrJ06DrWZrLXOreXy
         WCG8PMykRR3/lSQxA65BEcF/9oaQRdT4i8A/KBvELObtjC/n8gUff0AqydoDujBqew
         u2bbKnaH+7O57LPXEc1dB01sKJMvCf4n38LAZzYsVGSn5+G4lb27hbZZvDDGrLnKTe
         vkAhat+pspxwFBTM49pfQa0Mg0UnMqXtLUEdtI37isa6+7kKUXFus+Lxp+3MpdHFo9
         k23e7jNpA5yDw==
Date:   Thu, 5 Oct 2023 10:52:35 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] nvmet-fc: Annotate struct nvmet_fc_tgt_queue with
 __counted_by
Message-ID: <ZR7p01KL3546e2mr@kbusch-mbp.dhcp.thefacebook.com>
References: <20231005161408.it.584-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005161408.it.584-kees@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied to nvme-6.7.
