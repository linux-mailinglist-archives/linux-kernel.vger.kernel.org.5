Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22733802C49
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjLDHoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjLDHoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:44:03 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A90B9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 23:44:09 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5778F227A8E; Mon,  4 Dec 2023 08:44:07 +0100 (CET)
Date:   Mon, 4 Dec 2023 08:44:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bitao Hu <yaoma@linux.alibaba.com>
Cc:     sagi@grimberg.me, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
        kanie@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: fix deadlock between reset and scan
Message-ID: <20231204074407.GB29244@lst.de>
References: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me> <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
