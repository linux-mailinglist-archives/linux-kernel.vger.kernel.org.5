Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C417C4421
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbjJJWbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjJJWbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:31:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D66CA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KVFqgDD2WBJaGUmf4b4p+rG5Rz49c8za1StsCLhlpzA=; b=yPuLmoYZySK/xZ/2IJYvPaSLVg
        vr0PVwlnrEkdovEK2rRxE1oNpraqFn6OYz8bimhP2TXNQWaLfKU39QGwJ2FFC5GGeseVtrkztdh7A
        XnlsxD4paTLca3xEJX5R5W9CfeUCZi/23m+JNm9p4NTFTWIrVkVXdbLMYkQ4UVTjP1KHl7+JdIxy7
        VUlzliVwmMojT/5rM6AZzvEWtVcTxGFIPbsVGQqFQ1TOdsZIHH+S19juWxoTrqrqUBpNiHBzoegyU
        +TLsQ2EnmhvYBpH5+SJDRJMWLfHM9Ty01ocHhFqJJBlCj5ZDx+G3RG2TmDX2t0MTUfGpws6mB9Ii3
        q6Hr9N0Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qqLFc-00EGlO-0N;
        Tue, 10 Oct 2023 22:30:52 +0000
Date:   Tue, 10 Oct 2023 15:30:52 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     russell.h.weight@intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firmware_loader: Abort new fw load request once
 firmware core knows about reboot
Message-ID: <ZSXQnEf5VxOUZ/4g@bombadil.infradead.org>
References: <1696431327-7369-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696431327-7369-1-git-send-email-quic_mojha@quicinc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Seems like you just have to fix the 0-day build issues.

  Luis
