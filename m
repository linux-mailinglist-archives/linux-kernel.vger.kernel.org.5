Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146E5773C9E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjHHQID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjHHQGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:06:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089EF2D79;
        Tue,  8 Aug 2023 08:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38708625A1;
        Tue,  8 Aug 2023 14:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D98BC433C8;
        Tue,  8 Aug 2023 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691504860;
        bh=CrVCLDVCrfokMZc+EOGX1Ra4qTqjJvMfTL2+V0Uv7vM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FvoVlbeN+Bj6xMvtHL+sDb40UCQVpCd1kOjZp0jZ0fMf/ITTPjauh0zEPsUL4NuSN
         /hBDAIl764YYF+tV/mvW7ioPk9Zm0Uby2UeKjT+t4gVd5ZQploKyFRPpmrSy82ZiWn
         fb6SETMhoMqsf0lw+F323AUwfAzPCqbrCautx+cU=
Date:   Tue, 8 Aug 2023 16:27:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V26 0/3] misc: Add driver support for Data Capture and
 Compare unit(DCC)
Message-ID: <2023080846-important-junkyard-5433@gregkh>
References: <cover.1691496290.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691496290.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 05:58:24PM +0530, Souradeep Chowdhury wrote:
> Changes in v26
> 
> * Fixed the build error in V25 of the patch series

You did not do everything I asked of for the last review, why not?

I've dropped this from my review queue now.

greg k-h
