Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFDE7C9F45
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjJPGH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJPGH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:07:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAEC95
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 23:07:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 10D1C6732A; Mon, 16 Oct 2023 08:07:23 +0200 (CEST)
Date:   Mon, 16 Oct 2023 08:07:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Seamus Connor <sconnor@purestorage.com>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] configfs: improve item creation performance
Message-ID: <20231016060722.GA26408@lst.de>
References: <ZShUmLU3X5QMiWQH@google.com> <20231013211129.72592-1-sconnor@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013211129.72592-1-sconnor@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Seamus,

I've applied the patch (with two very minor coding style fixups)
to the configfs for-next branch.

