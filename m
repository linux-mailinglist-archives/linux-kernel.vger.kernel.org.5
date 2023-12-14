Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68938813883
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjLNR1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjLNR1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:27:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1906D12F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:27:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD53C433C7;
        Thu, 14 Dec 2023 17:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702574878;
        bh=jGJcFfxJ77Jia20J5i+bfYpM74CzLhm4TBQhqZKIItE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bDRVwxUMKTj8sYYBpuKOJdWVFGa3DUb6CUyS+B7krhljPalhiNlHpZ4jZzjOhX2//
         suIwCMLFmuGIWt/JuOs0s3u/wXsKVqja3AEyM8ud6dWMObhFe5rHwSJzRDCSN2QsFG
         GNt1YnFCfY7t79EjLqTn7K+Ze5Anc3Az2lucdMko2tUSwT5LW8Oe+28rw4H5kAyBkD
         bHNuMpl7/LrETLip4mSdlShzD1UvX+4hl3n1Ry5It1XdoQfbt5krrvwZ/cK9uLwtcN
         FK0csB8wDH6efkhYLoV5bhMSfcj8KDiJwlsCniOVGxwvVrrdW0kk4cQFI951zLcIVz
         CcmOC8rooSUBw==
Date:   Thu, 14 Dec 2023 09:27:57 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     JustinLai0215 <justinlai0215@realtek.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v14 13/13] MAINTAINERS: Add the rtase ethernet
 driver entry
Message-ID: <20231214092757.0456c978@kernel.org>
In-Reply-To: <34d0ca23a5c44dd8853c01379f4848e2@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
        <20231208094733.1671296-14-justinlai0215@realtek.com>
        <20231212112259.658d3a79@kernel.org>
        <34d0ca23a5c44dd8853c01379f4848e2@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 12:51:31 +0000 JustinLai0215 wrote:
> > https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html  
> 
> Larry Chiu is also one of the authors of this driver, so he is added as maintainer.
> I would like to ask if you have any questions about this part?

No questions at this stage, I just wanted to make sure you're familiar
with the guidelines. To avoid mistakes and misunderstandings later.
