Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D67B80D19F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbjLKQ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjLKQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:27:40 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EC895
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:27:45 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7650E68B05; Mon, 11 Dec 2023 17:27:42 +0100 (CET)
Date:   Mon, 11 Dec 2023 17:27:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v5 1/6] nvme: move ns id info to struct nvme_ns_head
Message-ID: <20231211162742.GA24001@lst.de>
References: <20231208105337.23409-1-dwagner@suse.de> <20231208105337.23409-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208105337.23409-2-dwagner@suse.de>
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
