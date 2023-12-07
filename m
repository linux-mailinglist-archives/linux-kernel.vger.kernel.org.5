Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0246808BAD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443527AbjLGPVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443450AbjLGPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:20:57 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5676B170C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:20:51 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B2F57227A88; Thu,  7 Dec 2023 16:20:48 +0100 (CET)
Date:   Thu, 7 Dec 2023 16:20:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Georg Gottleuber <g.gottleuber@tuxedocomputers.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Georg Gottleuber <ggo@tuxedocomputers.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Kingston drives
Message-ID: <20231207152048.GA20561@lst.de>
References: <20230920085210.22573-1-wse@tuxedocomputers.com> <12d32e8e-e20b-4023-8299-39d2a69c0cd9@tuxedocomputers.com> <20231206092420.GA27348@lst.de> <c930e543-7dab-4559-95d2-270b8df38f3b@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c930e543-7dab-4559-95d2-270b8df38f3b@tuxedocomputers.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok.  I guess we have to live with this quirk then :(

Reviewed-by: Christoph Hellwig <hch@lst.de>
