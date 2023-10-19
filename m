Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B585E7CEEDA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 06:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjJSE6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 00:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSE6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 00:58:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F77A4;
        Wed, 18 Oct 2023 21:58:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AC54B67373; Thu, 19 Oct 2023 06:58:30 +0200 (CEST)
Date:   Thu, 19 Oct 2023 06:58:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     djwong@kernel.org, willy@infradead.org, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] iomap: fix short copy in iomap_write_iter()
Message-ID: <20231019045830.GA13900@lst.de>
References: <8762e91a210f4cc5713fce05fe5906c18513bd0a.1697617238.git.jstancek@redhat.com> <e1cb4f8981f8c6e7e0384e95faf1911d9937e979.1697647960.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1cb4f8981f8c6e7e0384e95faf1911d9937e979.1697647960.git.jstancek@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
