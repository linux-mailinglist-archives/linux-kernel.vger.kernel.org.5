Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA94B7580E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjGRPbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjGRPbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648F4E8;
        Tue, 18 Jul 2023 08:31:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC2586162F;
        Tue, 18 Jul 2023 15:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6A8C433C7;
        Tue, 18 Jul 2023 15:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689694309;
        bh=UvS81nynzAskHbndFRf/Rn94S9fuk1KYmPk/g/MesL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+xmPqPNT46C/9ayWQvzmDHZv/ntnGcW8Xcdx44EDIg2wDncuMGisvPyJelAVPkz3
         ytCNUjuWvG1hHKThZ605G6qZsJH7H/dNZwUqoyYFw4RV4jzGpwMGO47h+opj4oXIPC
         FQ8rocsLSi3EiWJNTu7LeQXx0gdqZP3jgpkqixAV8ciBgOfHuMVADTAis8aCHgMUYi
         V3o4LbcONlkmDGO5Sxj8ON2Fqo0x3rt56UijOxSnbkykqcC/bKH//OX2CfhXuPtTmf
         ehVn8y3bX36Ia9HBsr7M0hp2HtujLuApk65fhkoSBStKXJ/3eAcOjNzpatT8uZlmKK
         VDxkhLNkYD66A==
Date:   Tue, 18 Jul 2023 08:35:12 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Vivek Pernamitta <quic_vpernami@quicinc.com>
Cc:     mhi@lists.linux.dev, mrana@quicinc.com, quic_qianyu@quicinc.com,
        manivannan.sadhasivam@linaro.org, quic_vbadigan@quicinc.com,
        quic_krichai@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] net: mhi : Add support to enable ethernet interface
Message-ID: <5b4okksnlobcm7sawopaayjciz4yp4y4b7vplacecqmgv5vtnk@oc2berflgkmr>
References: <1689660928-12092-1-git-send-email-quic_vpernami@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689660928-12092-1-git-send-email-quic_vpernami@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:45:28AM +0530, Vivek Pernamitta wrote:

Please drop the extra ' ' after "mhi" in $subject as well.

Thanks,
Bjorn
