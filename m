Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56547E4793
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjKGRuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjKGRuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:50:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C537A8F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:50:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D843C433C8;
        Tue,  7 Nov 2023 17:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699379400;
        bh=gEj4r5oaWUnXDzJh0xj5xkQh1EcU6cfqYKH7GdmGCH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nL+hHwYYCCuDGj2kuptuQh2rxLddC/24zCf/+m5vNKuPBtEzjInrtxrptUdB4CzpQ
         OkvGkjpd6hyNQ5ah0aWs5x8CcOtbDhDMKYAk7UsH3jL/Vm2u6n72+wPRsq7yt/4bZx
         Ah5+2uSvV3oQqtJZnmnY8vZSUQSPA5+fKuQ1jybL1gFEq7HEjIIkR4AUM6kczdAVpO
         NKJ65Q8+SWRvI71VaqifJR12uhHCqy/waLKO+Sh6wTp12reradkEzPgkXIoa/YnzXv
         kqP3jI1OTjMQ6uncDLryWRZ98pj9R3Ax6Gl4SihhY4ff7YgxLcYwhX0yx+QlpMargM
         KD9oHBWFHXuGw==
Date:   Tue, 7 Nov 2023 09:49:59 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net v2] page_pool: Add myself as page pool reviewer in
 MAINTAINERS
Message-ID: <20231107094959.556ffe53@kernel.org>
In-Reply-To: <20231107123825.61051-1-linyunsheng@huawei.com>
References: <20231107123825.61051-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 20:38:24 +0800 Yunsheng Lin wrote:
> I have added frag support for page pool, made some improvement
> for it recently, and reviewed some related patches too.
> 
> So add myself as reviewer so that future patch will be cc'ed
> to my email.

Not sure what to do about this, it feels somewhat wrong to add
as a reviewer someone who seem to not follow our basic process
requirements:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

:(
