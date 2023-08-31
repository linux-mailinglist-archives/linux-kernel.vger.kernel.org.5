Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D430278E8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbjHaJCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjHaJCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:02:48 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CEBCED;
        Thu, 31 Aug 2023 02:02:42 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qbdZW-009b2i-19; Thu, 31 Aug 2023 17:02:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 31 Aug 2023 17:02:39 +0800
Date:   Thu, 31 Aug 2023 17:02:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     thomas.lendacky@amd.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Fixes for dynamic boost control for 6.6
Message-ID: <ZPBXL0OVXMpp/BUb@gondor.apana.org.au>
References: <20230829150759.156126-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829150759.156126-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 10:07:54AM -0500, Mario Limonciello wrote:
>
> This series fixes all problems found. Ideally all patches should
> be submitted for a future 6.6-rc, but, the most important is
> "crypto: ccp: Get a free page to use while fetching initial nonce"
> if the rest must be pushed to 6.7.

As far as I can see it simply means that the new feature of DBC does
not work.  If that's all then I don't think it's an urgent issue and
this can wait until 6.7.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
