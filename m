Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519237B4967
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 21:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbjJATQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 15:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjJATQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 15:16:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9F4BA;
        Sun,  1 Oct 2023 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=caXieyxXvaEGBZ678iESMUrCFKC5EObSPEzSu2GkMAc=; b=ALFdPVrxOyW//ncprhk0e2c4Y3
        hNJM0uR1JsTg/cJxBNgdffZZkQvU3eIg6QbzLE8/eaqPSTfmtGpe4Et2eKNRxNY+hccjO7+PjNIXI
        2qCUwNz8rgToTYjiInVoJv0yEOHq3dJ3j4ltBuDdRiK6Vs+01Iryyv9R/NFT3HUYaN8yI+Dd5T5B6
        FUgOvvIz2+4BeBwUHHyWIyQ4DRH11T+ycv+QrGA9nuXqLh9+/QX4nKGAcjJ9J9AxT4HoUUByqwdHw
        pVTLO+6h6lDZ9NM2eUV2cnuePtylBGtEB8mgPhlj13Z/rcan3eeeYZQw8eM0U4JzBZ5lhqeBb9OOF
        21Rdf26Q==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qn1ve-00BYlp-1B;
        Sun, 01 Oct 2023 19:16:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: [PATCH 1/3] wifi: cfg80211: fix header kernel-doc typos
Date:   Sun,  1 Oct 2023 12:16:31 -0700
Message-ID: <20231001191633.19090-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling of several words.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 include/net/cfg80211.h |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff -- a/include/net/cfg80211.h b/include/net/cfg80211.h
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2443,7 +2443,7 @@ struct mesh_config {
  * @user_mpm: userspace handles all MPM functions
  * @dtim_period: DTIM period to use
  * @beacon_interval: beacon interval to use
- * @mcast_rate: multicat rate for Mesh Node [6Mbps is the default for 802.11a]
+ * @mcast_rate: multicast rate for Mesh Node [6Mbps is the default for 802.11a]
  * @basic_rates: basic rates to use when creating the mesh
  * @beacon_rate: bitrate to be used for beacons
  * @userspace_handles_dfs: whether user space controls DFS operation, i.e.
@@ -2713,7 +2713,7 @@ struct cfg80211_bss_select_adjust {
  * @match_sets: sets of parameters to be matched for a scan result
  *	entry to be considered valid and to be passed to the host
  *	(others are filtered out).
- *	If ommited, all results are passed.
+ *	If omitted, all results are passed.
  * @n_match_sets: number of match sets
  * @report_results: indicates that results were reported for this request
  * @wiphy: the wiphy this was for
@@ -2747,7 +2747,7 @@ struct cfg80211_bss_select_adjust {
  *	to the specified band while deciding whether a better BSS is reported
  *	using @relative_rssi. If delta is a negative number, the BSSs that
  *	belong to the specified band will be penalized by delta dB in relative
- *	comparisions.
+ *	comparisons.
  */
 struct cfg80211_sched_scan_request {
 	u64 reqid;
@@ -3587,7 +3587,7 @@ struct cfg80211_update_ft_ies_params {
  * This structure provides information needed to transmit a mgmt frame
  *
  * @chan: channel to use
- * @offchan: indicates wether off channel operation is required
+ * @offchan: indicates whether off channel operation is required
  * @wait: duration for ROC
  * @buf: buffer to transmit
  * @len: buffer length
@@ -3705,7 +3705,7 @@ struct cfg80211_nan_func_filter {
  * @publish_bcast: if true, the solicited publish should be broadcasted
  * @subscribe_active: if true, the subscribe is active
  * @followup_id: the instance ID for follow up
- * @followup_reqid: the requestor instance ID for follow up
+ * @followup_reqid: the requester instance ID for follow up
  * @followup_dest: MAC address of the recipient of the follow up
  * @ttl: time to live counter in DW.
  * @serv_spec_info: Service Specific Info
@@ -6714,7 +6714,7 @@ static inline const u8 *cfg80211_find_ie
  * @ies: data consisting of IEs
  * @len: length of data
  *
- * Return: %NULL if the etended element could not be found or if
+ * Return: %NULL if the extended element could not be found or if
  * the element is invalid (claims to be longer than the given
  * data) or if the byte array doesn't match; otherwise return the
  * requested element struct.
@@ -6861,7 +6861,7 @@ int regulatory_hint(struct wiphy *wiphy,
 /**
  * regulatory_set_wiphy_regd - set regdom info for self managed drivers
  * @wiphy: the wireless device we want to process the regulatory domain on
- * @rd: the regulatory domain informatoin to use for this wiphy
+ * @rd: the regulatory domain information to use for this wiphy
  *
  * Set the regulatory domain information for self-managed wiphys, only they
  * may use this function. See %REGULATORY_WIPHY_SELF_MANAGED for more
@@ -6952,7 +6952,7 @@ bool regulatory_pre_cac_allowed(struct w
  * Regulatory self-managed driver can use it to proactively
  *
  * @alpha2: the ISO/IEC 3166 alpha2 wmm rule to be queried.
- * @freq: the freqency(in MHz) to be queried.
+ * @freq: the frequency (in MHz) to be queried.
  * @rule: pointer to store the wmm rule from the regulatory db.
  *
  * Self-managed wireless drivers can use this function to  query
@@ -9129,9 +9129,9 @@ bool cfg80211_iftype_allowed(struct wiph
 
 /**
  * cfg80211_assoc_comeback - notification of association that was
- * temporarly rejected with a comeback
+ * temporarily rejected with a comeback
  * @netdev: network device
- * @ap_addr: AP (MLD) address that rejected the assocation
+ * @ap_addr: AP (MLD) address that rejected the association
  * @timeout: timeout interval value TUs.
  *
  * this function may sleep. the caller must hold the corresponding wdev's mutex.
